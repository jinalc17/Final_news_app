//
//  HistoryNewsTableViewCell.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/13/24.
//

import UIKit

class HistoryNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newsContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //configure label text
    func configure(with newsData: (String, String, String, String, String, String, String)) {
        
        newsLabel.text = newsData.0
        cityLabel.text = newsData.1
        fromLabel.text = newsData.2
        titleLabel.text = newsData.3
        newsContent.text = newsData.4
        sourceLabel.text = newsData.5
        authorLabel.text = newsData.6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
