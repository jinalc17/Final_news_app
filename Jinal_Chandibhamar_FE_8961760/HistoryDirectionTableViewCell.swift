//
//  HistoryDirectionTableViewCell.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/13/24.
//

import UIKit

class HistoryDirectionTableViewCell:
    UITableViewCell {
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var startPoint: UILabel!
    @IBOutlet weak var endPoint: UILabel!
    @IBOutlet weak var travelMethod: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //configure label data
    func configure(with data: (String, String, String, String, String, String, String)) {
            directionLabel.text = data.0
            cityLabel.text = data.1
            fromLabel.text = data.2
            startPoint.text = data.3
            endPoint.text = data.4
            travelMethod.text = data.5
            distance.text = data.6
        }

}
