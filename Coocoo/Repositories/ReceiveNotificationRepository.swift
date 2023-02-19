//
//  ReceiveNotificationRepository.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine
import UserNotifications

protocol ReceiveNotificationRepository {
    func receivedNotificationPublisher(name: CustomNotificationNames) -> AnyPublisher<Notification, Never>
}

struct ReceiveNotificationDataStore: ReceiveNotificationRepository {
    func receivedNotificationPublisher(name: CustomNotificationNames) -> AnyPublisher<Notification, Never> {
        NotificationCenter.default.publisher(for: .init(name.rawValue), object: nil)
            .eraseToAnyPublisher()
    }
}
