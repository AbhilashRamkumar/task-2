//
//  tableListCell.swift
//  conference room booking
//
//  Created by Admin on 12/04/19.
//  Copyright © 2019 Xiphias Softwares. All rights reserved.
//

import UIKit

class tableListCell: UITableViewCell {

    
    @IBOutlet weak var nameDetails: UILabel!
    @IBOutlet weak var dateDetails: UILabel!
    @IBOutlet weak var startTimeDetails: UILabel!
    @IBOutlet weak var endTimeDetails: UILabel!
    @IBOutlet weak var ConferenceHallDetails: UILabel!
    
   

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
    


