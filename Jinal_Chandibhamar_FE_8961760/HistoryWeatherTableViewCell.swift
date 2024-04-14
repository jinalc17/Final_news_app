//
//  HistoryWeatherTableViewCell.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/13/24.
//

import UIKit

class HistoryWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //configure label data
    func configure(with data: (String, String, String, String, String, String, String, String)) {
            labelWeather.text = data.0
            labelCity.text = data.1
            fromLabel.text = data.2
            dateLabel.text = data.3
            timeLabel.text = data.4
            tempLabel.text = data.5
            humidityLabel.text = data.6
            windLabel.text = data.7
        }

}
