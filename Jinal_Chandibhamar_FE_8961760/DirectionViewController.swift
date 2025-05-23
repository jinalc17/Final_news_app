//
//  DirectionViewController.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/12/24.
//

import UIKit
import MapKit
import CoreLocation

class DirectionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var zoomSlider: UISlider!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var bikeButton: UIButton!
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var busButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var startCoordinate: CLLocationCoordinate2D?
    var endCoordinate: CLLocationCoordinate2D?
    var currentCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Set startCoordinate to user's current location
            startCoordinate = location.coordinate
            // Add pin for start point
            addPin(coordinate: startCoordinate, title: "Start Point", subtitle: nil)
            // Zoom to user's current location
            zoomToLocation(coordinate: startCoordinate)
            // Stop updating location once obtained
            locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonClicked(_ sender: Any) {
        // Remove existing polyline overlays
        mapView.removeOverlays(mapView.overlays)
        // Present an alert to enter the start and destination cities
            let alertController = UIAlertController(title: "Enter Start and Destination Cities", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Start City"
            }
            alertController.addTextField { textField in
                textField.placeholder = "Destination City"
            }
            
            // Create an "OK" action
            let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let textFields = alertController.textFields, textFields.count == 2 else { return }
                guard let startCity = textFields[0].text, let destinationCity = textFields[1].text else { return }
                // Update the start and end points and draw route
                self?.currentCity = destinationCity
                self?.updateStartPoint(city: startCity)
                self?.updateEndPoint(city: destinationCity)
            }
            alertController.addAction(confirmAction)
            
            // Create a "Cancel" action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
    }
    
    func updateStartPoint(city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error
                print("Error geocoding the start city: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            // Set startCoordinate to the location of the entered start city
            self?.startCoordinate = location.coordinate
            // Add pin for start point
            self?.addPin(coordinate: location.coordinate, title: "Start Point", subtitle: city)
        }
    }

    func updateEndPoint(city: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle error
                print("Error geocoding the destination city: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            // Set endCoordinate to the location of the entered destination city
            self?.endCoordinate = location.coordinate
            // Add pin for end point
            self?.addPin(coordinate: location.coordinate, title: "End Point", subtitle: city)
            // Draw route
            self?.drawRoute()
        }
    }
    
    func addPin(coordinate: CLLocationCoordinate2D?, title: String, subtitle: String?) {
        guard let coordinate = coordinate else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
    
    func drawRoute(mode: MKDirectionsTransportType = .automobile) {
        mapView.removeOverlays(mapView.overlays)
        guard let start = startCoordinate, let end = endCoordinate else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = mode // Set transportation mode
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else {
                // Handle error
                print("Error calculating directions: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let route = response.routes[0]
            // Add the route as a polyline to the map
            self?.mapView.addOverlay(route.polyline)
        }
    }
    
    
    func addPin(coordinate: CLLocationCoordinate2D, title: String, subtitle: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    @IBAction func zoomSliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        // Invert the slider value to reverse zoom functionality
        let invertedValue = 1 - value
        // Use inverted value to set latitude and longitude deltas
        let region = MKCoordinateRegion(center: mapView.region.center, span: MKCoordinateSpan(latitudeDelta: Double(invertedValue), longitudeDelta: Double(invertedValue)))
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func carButtonTapped(_ sender: UIButton) {
        // Set transportation mode and update route
        drawRoute(mode: .automobile)
    }
    
    @IBAction func bikeButtonTapped(_ sender: UIButton) {
        // Set transportation mode and update route
        drawRoute(mode: .automobile)
    }
    
    @IBAction func walkButtonTapped(_ sender: UIButton) {
        // Set transportation mode and update route
        drawRoute(mode: .walking)
    }
    
    @IBAction func busButtonTapped(_ sender: UIButton) {
        // Set transportation mode and update route
        drawRoute(mode: .transit)
    }
    
    func zoomToLocation(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    
}
