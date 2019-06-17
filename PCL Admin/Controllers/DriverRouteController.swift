//
//  DriverRouteController.swift
//  PCL Admin
//
//  Created by Manoj on 6/7/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class DriverRouteController: UITableViewController {

    var driver: Driver?
    var customers: [Customer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if driver != nil {
            customers = driver!.route?.cutomers?.allObjects as? [Customer] ?? []
            customers.sort(by: { (c1, c2) in
                let formatter = DateFormatter()
                formatter.dateFormat = "hh : mm a"
                let t1 = formatter.date(from: c1.pickUpTime!)
                let t2 = formatter.date(from: c2.pickUpTime!)
                return t1!.time < t2!.time
            })
            let currentTime = Date()
            for cust in customers {
                let custTime = cust.pickUpTime!
                let formatter = DateFormatter()
                formatter.dateFormat = "hh : mm a"
                let custDT = formatter.date(from: custTime)
                if (custDT!.time < currentTime.time) && (cust.pickUpStatus ?? CollectionStatus.other.rawValue == CollectionStatus.other.rawValue){
                    driver?.route?.status = "Delayed"
                    break
                } else {
                    driver?.route?.status = "On Time"
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationStatusCell", for: indexPath) as! LocationStatusCell
        if customers.count > 0 {
            cell.populateCell(customer: customers[indexPath.row])
        }
        return cell
    }

    @IBAction func logoutTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let customer = customers[tableView.indexPathForSelectedRow!.row]
        if let vc = segue.destination as? DriverCustomerController {
            vc.customer = customer
        }
    }

}
