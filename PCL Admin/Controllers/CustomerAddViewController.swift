//
//  CustomerAddViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class CustomerAddViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var customerNameTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        for aField in textFields
        {
            aField.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
            aField.layer.borderWidth = 1
            aField.layer.cornerRadius = 8
        }
        for aButton in buttons {
            aButton.layer.cornerRadius = 8
        }
        timePicker.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        timePicker.layer.borderWidth = 1
        timePicker.layer.cornerRadius = 8
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        for aField in textFields
        {
            aField.text = ""
        }
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        for aField in textFields
        {
            if aField.text!.isEmpty {return}
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "hh : mm a"
        let time = dateFormat.string(from: timePicker.date)
        let cust = CustomerModel(name: customerNameTF.text!, street: streetTF.text!, city: cityTF.text!, state: stateTF.text!, zip: zipTF.text!, pickUpTime: time)
        DataHandler.addCustomer(cust)
        self.dismiss(animated: true, completion: nil)
    }
   
}
