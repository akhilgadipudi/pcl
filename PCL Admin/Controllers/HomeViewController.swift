//
//  ViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/2/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allRoutes: [Route] = []
    @IBOutlet weak var totalCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //DataHandler.resetAllData()
        tableView.delegate = self
        tableView.dataSource = self
        allRoutes = DataHandler.getRoutes()
        totalCount.text = String(DataHandler.getTotalSpecimenCount())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! RouteCell
        if indexPath.row < allRoutes.count {
            cell.populateCell(route: allRoutes[indexPath.row])
        }
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "routeDetailsSegue" {
            let vc = segue.destination as! RouteDetailsViewController
            vc.route = allRoutes[tableView.indexPathForSelectedRow!.row]
        }
    }

    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        totalCount.text = String(DataHandler.getTotalSpecimenCount())
        allRoutes = DataHandler.getRoutes()
        tableView.reloadData()
    }
}

