//
//  DriverLoginController.swift
//  PCL Admin
//
//  Created by Manoj on 6/7/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class DriverLoginController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var driver: Driver?
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.cornerRadius = 8
        phoneTextField.layer.borderColor = UIColor.init(red: 128/255, green: 25/255, blue: 50/255, alpha: 1).cgColor
        loginButton.layer.cornerRadius = 8
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
        guard phoneTextField.text != nil else {return}
        guard let driver = DriverDataHandler.getDriver(phone: phoneTextField.text!) else {return}
        self.driver = driver
        performSegue(withIdentifier: "driverLoginSegue", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "driverLoginSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first! as! DriverRouteController
            vc.driver = driver
        }
    }


}
