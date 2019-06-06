//
//  Driver.swift
//  PCL Admin
//
//  Created by Manoj on 6/4/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation

struct DriverModel: Codable {
    let firstName: String
    let lastName: String
    let phone: String
}

extension DriverModel {
    init(_ dict: [String : String]) {
        self.firstName = dict["firstName"] ?? ""
        self.lastName = dict["lastName"] ?? ""
        self.phone = dict["phone"] ?? ""
    }
    
//    init(firstName: String, lastName: String, phone: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.phone = phone
//    }
    
    func toDict() -> [String : String]{
        return ["firstName" : self.firstName, "lastName" : self.lastName, "phone" : self.phone]
    }
}
