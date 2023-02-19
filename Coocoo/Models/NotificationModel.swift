//
//  NotificationModel.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Foundation


struct NotificationModel: Equatable {
    let title: String
    let message: String
}

extension Notification.Name {
    init(notificationNames: CustomNotificationNames) {
        self = Notification.Name(rawValue: notificationNames.rawValue)
    }
}


enum CustomNotificationNames: String {
    case customNotificationOne
    case customNotificationsTwo
}
