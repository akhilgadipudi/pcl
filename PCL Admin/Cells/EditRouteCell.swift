//
//  ExistingRouteCell.swift
//  PCL Admin
//
//  Created by Manoj on 6/6/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class EditRouteCell: UITableViewCell {
    @IBOutlet var routeNo: UILabel!
    @IBOutlet var routeName: UILabel!
    @IBOutlet var driver: UILabel!
    @IBOutlet var vehicle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populateCell(_ route: Route) {
        self.routeNo.text = route.num
        self.routeName.text = route.name
        self.driver.text = route.driver!.firstName! + " " + route.driver!.lastName!
        self.vehicle.text = route.vehicle
    }
}
