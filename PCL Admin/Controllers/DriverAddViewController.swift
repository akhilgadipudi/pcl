//
//  DriverAddViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/3/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class DriverAddViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var buttons: [UIButton]!

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    
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
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        firstNameTF.text = ""
        lastNameTF.text = ""
        phoneTF.text = ""
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        guard !firstNameTF.text!.isEmpty && !lastNameTF.text!.isEmpty && !phoneTF.text!.isEmpty else {
            print("driver fields empty")
            return
        }
//        let driver = Driver()
//        driver.firstName = firstNameTF.text!
//        driver.lastName = lastNameTF.text!
//        driver.phone = phoneTF.text!
        let d = DriverModel(firstName: firstNameTF.text!, lastName : lastNameTF.text!, phone : phoneTF.text!)
        DataHandler.addDriver(d)
        self.dismiss(animated: true, completion: nil)
    }
}
