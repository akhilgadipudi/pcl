//
//  EditRouteViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class ExistingRoutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var routesTable: UITableView!
    var allRoutes : [Route] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routesTable.delegate = self
        routesTable.dataSource = self
        allRoutes = DataHandler.getRoutes()
        //routesTable?.reloadData()
        //print("routes in list : \(allRoutes.count)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRoutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.routesTable.dequeueReusableCell(withIdentifier: "EditRouteCell") as! EditRouteCell
        if allRoutes.count > 0 {
            cell.populateCell(allRoutes[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let presentingController: RouteEditorViewController
        presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoutesEditor") as! RouteEditorViewController
        presentingController.myRoute = allRoutes[indexPath.row]
        presentingController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        present(presentingController, animated: true, completion: nil)
    }
}
