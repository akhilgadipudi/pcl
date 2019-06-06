//
//  Location.swift
//  PCL Admin
//
//  Created by Manoj on 6/2/19.
//  Copyright © 2019 akhil. All rights reserved.
//

import Foundation

enum CollectionStatus: String {
    case notCollected = "NotCollected"
    case collected = "Collected"
    case rescheduled = "Rescheduled"
    case missed = "Missed"
    case closed = "Closed"
    case other = "Other"
}

struct Location {
    let labName: String
    let address: String
    let collectionStatus: CollectionStatus
    let specimenCount: String
    let pickedUpBy: String
    let pickUpTime: String
    let locationId: String
    var isSelected: Bool
}
