//
//  SettingsViewController.swift
//  PCL Admin
//
//  Created by Manoj on 6/2/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = String(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let presentingController: UIViewController
        switch indexPath.row {
        case 0:
            presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DriverAddView") as! DriverAddViewController
            presentingController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        case 1:
            presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomerAddView") as! CustomerAddViewController
            presentingController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        case 2:
            presentingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoutesEditor") as! RouteEditorViewController
            presentingController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        default:
            return
        }
        present(presentingController, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
