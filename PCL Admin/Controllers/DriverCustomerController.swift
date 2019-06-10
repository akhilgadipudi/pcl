//
//  DriverCustomerController.swift
//  PCL Admin
//
//  Created by Manoj on 6/7/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit
import MapKit

class DriverCustomerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var accountNumLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var specimenCountTF: UITextField!
    @IBOutlet weak var statusPicker: UIPickerView!
    
    weak var customer: Customer?
    let statusArr = [CollectionStatus.collected.rawValue, CollectionStatus.notCollected.rawValue,CollectionStatus.missed.rawValue, CollectionStatus.closed.rawValue,CollectionStatus.rescheduled.rawValue, CollectionStatus.other.rawValue]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        statusPicker.delegate = self
        statusPicker.dataSource = self
        statusPicker.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        statusPicker.layer.borderWidth = 1
        statusPicker.layer.cornerRadius = 8
        
        guard customer != nil else {return}
        accountNumLbl.text = String(customer!.accountNum)
        customerNameLbl.text = customer!.name
        timeLbl.text = customer!.pickUpTime
        let addr = "\(customer!.street ?? ""), \(customer!.city ?? ""), \(customer!.state ?? "") \(customer!.zip ?? "")"
        addressLbl.text = addr
        specimenCountTF.text = customer!.specimenCount
        statusPicker.selectRow(statusArr.count-1, inComponent: 0, animated: false)
        for i in 0..<statusArr.count {
            if statusArr[i] == customer!.pickUpStatus {
                statusPicker.selectRow(i, inComponent: 0, animated: false)
            }
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusArr[row]
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        guard specimenCountTF.text != nil else {return}
        customer?.specimenCount = specimenCountTF.text
        let selectedStatus = statusArr[statusPicker.selectedRow(inComponent: 0)]
        customer?.pickUpStatus = selectedStatus
        DriverDataHandler.saveCustomerChange()
    }
    
    @IBAction func getDirectionsTapped(_ sender: UIButton) {
        let addr = "\(customer!.street ?? ""), \(customer!.city ?? ""), \(customer!.state ?? "") \(customer!.zip ?? "")"
        LocationHelper.getlatlong(address: addr, completion: {(lat, lon) in
            self.openMapForPlace(lat: lat, lon: lon)
        })
    }
    
    func openMapForPlace(lat: Double, lon: Double) {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lon
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = customer?.name ?? ""
        mapItem.openInMaps(launchOptions: options)
    }
    
}
