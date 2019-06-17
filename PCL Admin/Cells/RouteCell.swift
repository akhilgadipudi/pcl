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
    
    func populateCell(route: Route){
        routeNum.text = route.num
        driverName.text = route.driver!.firstName! + " " + route.driver!.lastName!
        
        var customers = route.cutomers!.allObjects as! [Customer]
        customers.sort(by: { (c1, c2) in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh : mm a"
            let t1 = formatter.date(from: c1.pickUpTime!)
            let t2 = formatter.date(from: c2.pickUpTime!)
            return t1!.time < t2!.time
        })
        pickUpTime.text = customers[0].pickUpTime!
        
        var specimenTotal = 0
        for cust in customers {
            specimenTotal =  specimenTotal + (Int(cust.specimenCount ?? "0") ?? 0)
        }
        specimenCount.text = "Speciment Count : \(specimenTotal)"
        for dotView in locationStatusContainer.subviews {
            dotView.removeFromSuperview()
        }
        var x = 0
        for cust in customers {
            var dotImg: UIImage
            let status = cust.pickUpStatus ?? "Other"
            if status == CollectionStatus.notCollected.rawValue {
                dotImg = UIImage(named: "redDot") ?? UIImage()
            } else if status == CollectionStatus.collected.rawValue {
                dotImg = UIImage(named: "greenDot") ?? UIImage()
            } else if status == CollectionStatus.missed.rawValue {
                dotImg = UIImage(named: "yellowDot") ?? UIImage()
            } else if status == CollectionStatus.rescheduled.rawValue {
                dotImg = UIImage(named: "blueDot") ?? UIImage()
            } else if status == CollectionStatus.closed.rawValue {
                dotImg = UIImage(named: "closedDot") ?? UIImage()
            } else if status == CollectionStatus.other.rawValue {
                dotImg = UIImage(named: "greyDot") ?? UIImage()
            } else {
                dotImg = UIImage()
            }
            let imgV = UIImageView(image: dotImg)
            imgV.frame = CGRect(x: x, y: 0, width: 25, height: 25)
            x = x + 30
            locationStatusContainer.addSubview(imgV)
        }
        
        routeStatus.text = route.status ?? "Status"
    }

}
