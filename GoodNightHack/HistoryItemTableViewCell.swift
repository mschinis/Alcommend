//
//  HistoryItemTableViewCell.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 09/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class HistoryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    
    var item:PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
