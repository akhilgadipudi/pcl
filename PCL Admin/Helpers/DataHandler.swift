//
//  DataHandler.swift
//  PCL Admin
//
//  Created by Manoj on 6/4/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataHandler{
    static func addDriver(_ driver: DriverModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newDriver = Driver(context: managedContext)
        newDriver.firstName = driver.firstName
        newDriver.lastName = driver.lastName
        newDriver.phone = driver.phone
        appDelegate.saveContext()
    }
    
    static func getDrivers() -> [Driver]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Driver")
        do {
            let drivers = try managedContext.fetch(fetchRequest) as! [Driver]
            return drivers
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func addCustomer(_ cust: CustomerModel){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        var id: Int16 = 0
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")
        do {
            let customers = try managedContext.fetch(fetchRequest) as! [Customer]
            id = Int16(customers.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let newCust = Customer(context: managedContext)
        newCust.name = cust.name
        newCust.street = cust.street
        newCust.city = cust.city
        newCust.state = cust.state
        newCust.zip = cust.zip
        newCust.pickUpTime = cust.pickUpTime
        newCust.accountNum = id + 1
        
        appDelegate.saveContext()
    }
    
    static func getCustomers() -> [Customer]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")
        do {
            let customers = try managedContext.fetch(fetchRequest) as! [Customer]
            return customers
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func getLocations() -> [Location]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Customer")
        do {
            let customers = try managedContext.fetch(fetchRequest) as! [Customer]
            var locations: [Location] = []
            for cust in customers {
                let addr = "\(cust.street ?? ""), \(cust.city ?? ""), \(cust.state ?? "") \(cust.zip ?? "")"
                let l = Location(labName: cust.name!, address: addr, collectionStatus: .other, specimenCount: "", pickedUpBy: "", pickUpTime: cust.pickUpTime!, locationId: String(cust.accountNum), isSelected: false)
                locations.append(l)
            }
            return locations
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func locationsFormCustomers(customers: NSSet) -> [Location]{
        var locations: [Location] = []
        for aCustomer in customers {
            let cust = aCustomer as! Customer
            let addr = "\(cust.street ?? ""), \(cust.city ?? ""), \(cust.state ?? "") \(cust.zip ?? "")"
            let l = Location(labName: cust.name!, address: addr, collectionStatus: .other, specimenCount: "", pickedUpBy: "", pickUpTime: cust.pickUpTime!, locationId: String(cust.accountNum), isSelected: false)
            locations.append(l)
        }
        return locations
    }
    
    static func customersFromLocations(locations: [Location]) -> NSSet {
        let allCustomers = getCustomers()
        var routeCustomers: [Customer] = []
        for aCustomer in allCustomers {
            for aLocation in locations {
                if aLocation.labName == aCustomer.name {
                    routeCustomers.append(aCustomer)
                }
            }
        }
        return NSSet(array: routeCustomers)
    }
    
    static func addRoute(name: String, num: String, driver: Driver, vehicle: String, locations: [Location]){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let route = Route(context: managedContext)
        route.name = name
        route.num = num
        route.driver = driver
        route.vehicle = vehicle
        route.cutomers = customersFromLocations(locations: locations)
        appDelegate.saveContext()
    }
    
    static func editRoute(route: Route, name: String, num: String, driver: Driver, vehicle: String, locations: [Location]){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        route.name = name
        route.num = num
        route.driver = driver
        route.vehicle = vehicle
        route.cutomers = customersFromLocations(locations: locations)
        appDelegate.saveContext()
    }
    
    static func deleteRoute(route: Route){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(route)
        appDelegate.saveContext()
    }
    
    static func getRoutes() -> [Route] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Route")
        do {
            let routes = try managedContext.fetch(fetchRequest) as! [Route]
            return routes
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func resetAllData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entites = appDelegate.persistentContainer.managedObjectModel.entities
        for entity in entites {
            let fetch = NSFetchRequest<NSManagedObject>(entityName: entity.name!)
            do {
                let items = try managedContext.fetch(fetch)
                for item in items {
                    managedContext.delete(item)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        appDelegate.saveContext()
    }
    
    static func getTotalSpecimenCount() -> Int{
        var count = 0
        let customers = getCustomers()
        for cust in customers {
            count = count + (Int(cust.specimenCount ?? "0") ?? 0)
        }
        return count
    }
}
