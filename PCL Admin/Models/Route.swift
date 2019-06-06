//
//  Route.swift
//  PCL Admin
//
//  Created by Manoj on 6/2/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation

struct RouteModel {
    let routeNo: String
    let assignee: String
    let routeName: String
    let vehicleNo: String
    var locations: [Location]
}
