//
//  ViewController.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/9/24.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var discoverButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var weatherInfo: UITextView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request location authorization
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Setup mapView
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
            
            // Add a pin for the current location
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
            
            // Fetch weather data using the user's location coordinates
            fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=d3f0956caa7ad29a06e029f9a9cb7c0e")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.updateWeatherInfo(weatherData)
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    //update labels
    func updateWeatherInfo(_ weather: Weather) {
        let cityName = weather.name
        let temperature = weather.main.temp
        let temperatureInCelsius = temperature - 273.15 // Convert Kelvin to Celsius
        let humidity = weather.main.humidity
        let windSpeed = weather.wind.speed
        let windSpeedInKilometersPerHour = windSpeed * 3.6 // Convert m/s to km/h
        
        let weatherText = """
                 \(String(format: "%.1f", temperatureInCelsius))°C
                Humidity: \(humidity)%
                Wind: \(String(format: "%.1f", windSpeedInKilometersPerHour)) km/h
                """
        
        weatherInfo.text = weatherText
    }
}
