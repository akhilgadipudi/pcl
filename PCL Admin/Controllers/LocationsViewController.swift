//
//  LocationsViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var allLocations: [Location] = []
    var delegate: RouteEditorViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 8
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        allLocations = DataHandler.getLocations()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLocations.count
        //return allLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddLocationCell") as! AddLocationCell
        cell.populateCell(allLocations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var selectedLocation = allLocations[indexPath.row]
        selectedLocation.isSelected = !selectedLocation.isSelected
        allLocations.remove(at: indexPath.row)
        allLocations.insert(selectedLocation, at: indexPath.row)
        tableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton)
    {
        for aLocation in allLocations
        {
            if aLocation.isSelected
            {
                self.delegate?.routeLocations.append(aLocation)
            }
        }
        self.delegate?.locationsTable.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
