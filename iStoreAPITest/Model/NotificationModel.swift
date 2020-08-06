//
//  NotificationModel.swift
//  iStoreAPITest
//
//  Created by Eldar on 05.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

struct NotificationModel: Codable {
    let id: Int
    let titleImage: String
    let title: String
    let notificationImage: String
    let date: String
    let time: String
    let notificationDescription: String
    let link: String
}
