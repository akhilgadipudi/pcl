//
//  LocationStatusCell.swift
//  PCL Admin
//
//  Created by Manoj on 6/6/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class LocationStatusCell: UITableViewCell {
    @IBOutlet weak var accountNum: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var address: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(customer: Customer){
        accountNum.text = String(customer.accountNum)
        locationName.text = customer.name
        pickUpTime.text = customer.pickUpTime
        let addr = "\(customer.street ?? ""), \(customer.city ?? ""), \(customer.state ?? "") \(customer.zip ?? "")"
        address.text = addr
        let specimen = (Int(customer.specimenCount ?? "0") ?? 0)
        details.text = "Speciment Count : \(specimen)"
        status.text = customer.pickUpStatus ?? CollectionStatus.other.rawValue
        
        let s = customer.pickUpStatus ?? CollectionStatus.other.rawValue
        if s == CollectionStatus.notCollected.rawValue {
            status.textColor = .red
        } else if s == CollectionStatus.collected.rawValue {
            status.textColor = .green
        } else if s == CollectionStatus.missed.rawValue {
            status.textColor = .yellow
        } else if s == CollectionStatus.rescheduled.rawValue {
            status.textColor = .blue
        } else if s == CollectionStatus.closed.rawValue {
            status.textColor = .gray
        } else if s == CollectionStatus.other.rawValue {
            status.textColor = .black
        }
        
        if s != CollectionStatus.collected.rawValue {
            statusImg.image = UIImage()
        } else {
            statusImg.image = UIImage(named: "tick")
        }
    }

}
