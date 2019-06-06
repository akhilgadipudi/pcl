//
//  Customer.swift
//  PCL Admin
//
//  Created by Manoj on 6/4/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation

struct CustomerModel: Codable {
    var name: String
    var street: String
    var city: String
    var state: String
    var zip: String
    var pickUpTime: String
}
