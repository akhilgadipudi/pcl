//
//  DriverDataHandler.swift
//  PCL Admin
//
//  Created by Manoj on 6/7/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation
import  CoreData
import  UIKit

class DriverDataHandler {
    static func getDriver(phone: String) -> Driver? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Driver")
        fetchRequest.predicate = NSPredicate(format: "phone == %@", phone)
        do {
            let drivers = try managedContext.fetch(fetchRequest) as! [Driver]
            return drivers.first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    static func saveCustomerChange(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.saveContext()
    }
}
