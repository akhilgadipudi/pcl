//
//  DriversListViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class DriversListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var driversTable: UITableView!
    var delegate: RouteEditorViewController?
    var drivers: [Driver] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drivers = DataHandler.getDrivers()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if drivers.count < 1 {return cell}
        let name = drivers[indexPath.row].firstName! + " " + drivers[indexPath.row].lastName!
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedDriver = drivers[indexPath.row]
        delegate?.refreshDriver()
        self.dismiss(animated: true, completion: nil)
        
    }
}
