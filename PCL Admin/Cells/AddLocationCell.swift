//
//  AddLocationCell.swift
//  PCL Admin
//
//  Created by Manoj on 6/4/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class AddLocationCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var accNo: UILabel!
    @IBOutlet var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populateCell(_ location: Location) {
        name.text = location.labName
        address.text = location.address
        accNo.text = "#" + location.locationId
        if location.isSelected {
            selectButton.isSelected = true
        }
        else
        {
            selectButton.isSelected = false
        }
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

}
