//
//  RouteDetailsViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/6/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit
import MapKit

class RouteDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    weak var route: Route?
    var customers : [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 8
        tableView.layer.borderColor =  UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        mapView.layer.borderWidth = 1
        mapView.layer.cornerRadius = 8
        mapView.layer.borderColor =  UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        customers = route?.cutomers?.allObjects as? [Customer] ?? []
        customers.sort(by: { (c1, c2) in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh : mm a"
            let t1 = formatter.date(from: c1.pickUpTime!)
            let t2 = formatter.date(from: c2.pickUpTime!)
            return t1!.time < t2!.time
        })
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh : mm a"
        for cust in customers {
            let addr = "\(cust.street ?? ""), \(cust.city ?? ""), \(cust.state ?? "") \(cust.zip ?? "")"
            LocationHelper.getlatlong(address: addr, completion: { lat , lon in
                let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let point = Artwork(title: cust.name!, locationName: cust.name!, discipline: "", coordinate: coord)
                self.mapView.addAnnotation(point)
                self.mapView.fitAll()
            })
            let custDT = formatter.date(from: cust.pickUpTime!)
            if (custDT!.time < currentTime.time) && (cust.pickUpStatus ?? CollectionStatus.other.rawValue == CollectionStatus.other.rawValue){
                route?.status = "Delayed"
                break
            } else {
                route?.status = "On Time"
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationStatusCell") as! LocationStatusCell
        if customers.count > 0 {
           cell.populateCell(customer: customers[indexPath.row])
        }
        return cell
    }
    
}
