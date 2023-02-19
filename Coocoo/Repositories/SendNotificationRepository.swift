//
//  SendNotificationRepository.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine
import UserNotifications

protocol SendNotificationRepository {
    func sendNotification(title: String, message: String, name: CustomNotificationNames)
}


struct SendNotificationDataStore: SendNotificationRepository {

    func sendNotification(title: String, message: String, name: CustomNotificationNames) {
        let userInfo = ["title": title, "message": message]
        NotificationCenter.default.post(name: .init(name.rawValue), object: nil, userInfo: userInfo)
    }
}


