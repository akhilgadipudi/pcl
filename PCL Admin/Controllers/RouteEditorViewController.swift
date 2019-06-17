//
//  RouteEditorViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class RouteEditorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var driverButton: UIButton!
    @IBOutlet var locationsTable: UITableView!
    @IBOutlet var routeName: UITextField!
    @IBOutlet var vehicleButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var routeNum: UITextField!
    var myRoute: Route?
    
    var selectedDriver: Driver?
    var selectedVehicle = ""
    var routeLocations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if let aRoute = myRoute {
            self.routeNum.text = aRoute.num
            self.routeName.text = aRoute.name
            self.selectedDriver = aRoute.driver!
            self.selectedVehicle = aRoute.vehicle!
            self.routeLocations = DataHandler.locationsFormCustomers(customers: aRoute.cutomers!)
        }
        refreshDriver()
        refreshVehicle()
    }
    
    private func setupViews(){
        driverButton.layer.borderWidth = 1
        driverButton.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        driverButton.layer.cornerRadius = 8
        locationsTable.layer.borderWidth = 1
        locationsTable.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        locationsTable.layer.cornerRadius = 8
        routeName.layer.borderWidth = 1
        routeName.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        routeName.layer.cornerRadius = 8
        routeNum.layer.borderWidth = 1
        routeNum.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        routeNum.layer.cornerRadius = 8
        vehicleButton.layer.borderWidth = 1
        vehicleButton.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        vehicleButton.layer.cornerRadius = 8
        addButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8

        
    }
    
    @IBAction func driverButtonTapped(_ sender: UIButton){
        let presentingController: DriversListViewController
        presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DriversController") as! DriversListViewController
        presentingController.delegate = self
        presentingController.modalPresentationStyle = UIModalPresentationStyle.popover
        present(presentingController, animated: true, completion: nil)
        presentingController.preferredContentSize = CGSize(width: 300, height: 300)
        let popoverPresentationController = presentingController.popoverPresentationController
        popoverPresentationController?.sourceView = self.view
        popoverPresentationController?.sourceRect = sender.frame
        
    }
    
    @IBAction func vehicleButtonTapped(_ sender: UIButton){
        let presentingController: VehiclesListViewController
        presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VehiclesController") as! VehiclesListViewController
        presentingController.delegate = self
        presentingController.modalPresentationStyle = UIModalPresentationStyle.popover
        present(presentingController, animated: true, completion: nil)
        presentingController.preferredContentSize = CGSize(width: 300, height: 300)
        let popoverPresentationController = presentingController.popoverPresentationController
        popoverPresentationController?.sourceView = self.view
        popoverPresentationController?.sourceRect = sender.frame
        
    }
    
    func refreshDriver() {
        if selectedDriver != nil {
            let name = selectedDriver!.firstName! + " " + selectedDriver!.lastName!
            driverButton.setTitle("Driver: " + name, for: .normal)
        } else {
            driverButton.setTitle("Driver: " + "  ---  ", for: .normal)
        }
        
    }
    
    func refreshVehicle() {
        if selectedVehicle != "" {
            vehicleButton.setTitle("Vehicle: "+selectedVehicle, for: .normal)
        } else {
            vehicleButton.setTitle("Vehicle:   ----  " , for: .normal)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeLocations.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.locationsTable!.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        if(indexPath.row == routeLocations.count)
        {
            cell = self.locationsTable!.dequeueReusableCell(withIdentifier: "AddCell") as! LocationCell
            cell.textLabel?.text = "+"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 90, weight:UIFont.Weight.ultraLight)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1)
        }
        else
        {
            cell.seqNo.text = String(indexPath.row + 1)
            cell.populateCell(routeLocations[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == routeLocations.count)
        {
            let presentingController: LocationsViewController
            presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationsController") as! LocationsViewController
            presentingController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
            presentingController.delegate = self
            present(presentingController, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == routeLocations.count {return false}
        else {return true}
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            routeLocations.remove(at: indexPath.row)
            locationsTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        guard routeName.text != nil && routeNum.text != nil && selectedDriver != nil && selectedVehicle != "" && routeLocations.count > 0 else {return}
        
        if myRoute != nil {
            // Edit Route
            DataHandler.editRoute(route: myRoute!, name: routeName.text!, num: routeNum.text!, driver: selectedDriver!, vehicle: selectedVehicle, locations: routeLocations)
        } else {
            // Add Route
            DataHandler.addRoute(name: routeName.text!, num: routeNum.text!, driver: selectedDriver!, vehicle: selectedVehicle, locations: routeLocations)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

