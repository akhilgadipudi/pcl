//
//  LocationCell.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var accNo: UILabel!
    @IBOutlet var seqNo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(_ location: Location) {
        self.name.text = location.labName
        self.address.text = location.address
        self.accNo.text = "#" + location.locationId
    }

}
