//
//  HistoryViewController.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/13/24.
//

import UIKit


struct HistoryEntry {
    enum EntryType {
        case news
        case weather
        case direction
    }
    
    let type: EntryType
    let data: Any // Data associated with the entry, such as news article, weather info, or directions data
}

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var historyEntries: [HistoryEntry] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source
        tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "HistoryNewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "newsCell")
        let weatherNib = UINib(nibName: "HistoryWeatherTableViewCell", bundle: nil)
        tableView.register(weatherNib, forCellReuseIdentifier: "weatherCell")
        let directionNib = UINib(nibName: "HistoryDirectionTableViewCell", bundle: nil)
        tableView.register(directionNib, forCellReuseIdentifier: "directionCell")
        
        //add sample data
        addSampleHistoryEntries()
    }
    
    // Set the height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return your desired cell height
        return 170
    }
    
    // Optionally, set cell border properties
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        cell.contentView.layer.cornerRadius = 8.0
    }
    
    func addSampleHistoryEntries() {
        // Sample news data
        let newsEntry = HistoryEntry(type: .news, data: ("News", "Toronto", "From Home", "Puigdemont se traslada a vivir al sur de Francia para la campaña electoral", "El expresident y candidato de Junts a las elecciones del 12M, Carles Puigdemont, se ha dejado su residencia en Bélgica y se ha instalado en el sur de Francia", "CNN", "John Doe"))
        historyEntries.append(newsEntry)
        // Sample weather data
        let weatherEntry = HistoryEntry(type: .weather, data: ("Weather", "Waterloo", "From Home", "2024-04-13", "10:53 PM", "5°C", "Humidity: 10%", "Wind: 20 km/h"))
        historyEntries.append(weatherEntry)
        // Sample direction data
        let directionEntry = HistoryEntry(type: .direction, data: ("Directions", "Waterloo", "From Home", "Waterloo", "Toronto", "By Car", "Distance: 120 Km"))
        historyEntries.append(directionEntry)
        let weatherEntry2 = HistoryEntry(type: .weather, data: ("Weather", "Calgary", "From Home", "2024-04-13", "10:55 PM", "-5°C", "Humidity: 10%", "Wind: 32 km/h"))
        historyEntries.append(weatherEntry2)
        // Sample direction data
        let directionEntry2 = HistoryEntry(type: .direction, data: ("Directions", "Waterloo", "From Home", "Waterloo", "Cambridge", "By Car", "Distance: 20 Km"))
        historyEntries.append(directionEntry2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyEntries.count
    }
    
    
    //show entries
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = historyEntries[indexPath.row]
        
        switch entry.type {
        case .news:
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! HistoryNewsTableViewCell
            let newsData = entry.data as? (String, String, String, String, String, String, String)
            cell.configure(with: newsData!)
            return cell
        case .weather:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! HistoryWeatherTableViewCell
            let weatherData = entry.data as? (String, String, String, String, String, String, String, String)
            cell.configure(with: weatherData!)
            return cell
        case .direction:
            let cell = tableView.dequeueReusableCell(withIdentifier: "directionCell", for: indexPath) as! HistoryDirectionTableViewCell
            if let directionData = entry.data as? (String, String, String, String, String, String, String) {
                cell.configure(with: directionData)
            }
            return cell
        }
    }
    
    // Implement UITableViewDelegate method
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the history entry from the data source
            historyEntries.remove(at: indexPath.row)
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = historyEntries[indexPath.row]
        
        switch entry.type {
        case .news:
            // Navigate to the NewsViewController
            let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
            navigationController?.pushViewController(newsViewController, animated: true)
        case .weather:
            // Navigate to the WeatherViewController
            let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
            navigationController?.pushViewController(weatherViewController, animated: true)
            
        case .direction:
            // Navigate to the DirectionViewController
            let directionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DirectionViewController") as! DirectionViewController
            navigationController?.pushViewController(directionViewController, animated: true)
        }
    }
    
    
    
    
    
}
