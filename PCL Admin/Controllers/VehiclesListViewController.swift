//
//  VehiclesListViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class VehiclesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var vehiclesTable: UITableView!
    var delegate: RouteEditorViewController?
    let vehicles = ["PA 0001", "PA 0002", "PA 0003", "PA 0004", "PA 0005", "PA 0006", "PA 0007", "PA 0008"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = vehicles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedVehicle = vehicles[indexPath.row]
        delegate?.refreshVehicle()
        self.dismiss(animated: true, completion: nil)
        
    }

}
