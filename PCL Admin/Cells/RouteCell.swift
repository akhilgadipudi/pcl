//
//  RouteCell.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell {
    @IBOutlet weak var routeNum: UILabel!
    @IBOutlet weak var locationStatusContainer: UIView!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var specimenCount: UILabel!
    @IBOutlet weak var routeStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
