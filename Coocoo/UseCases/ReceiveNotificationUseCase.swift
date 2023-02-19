//
//  ReceiveNotificationUseCase.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine

protocol ReceiveNotificationUseCase {
    func receivedNotificationPublisher(name: CustomNotificationNames) -> AnyPublisher<NotificationModel, Never>
}

struct ReceiveNotificationInteractor: ReceiveNotificationUseCase {
    let repository: ReceiveNotificationRepository

    init(repository: ReceiveNotificationRepository = ReceiveNotificationDataStore()) {
        self.repository = repository
    }

    func receivedNotificationPublisher(name: CustomNotificationNames) -> AnyPublisher<NotificationModel, Never> {
        repository.receivedNotificationPublisher(name: name)
            .compactMap { notification in
                guard let title = notification.userInfo?["title"] as? String,
                      let message = notification.userInfo?["message"] as? String
                else {
                    return nil
                }
                return NotificationModel(title: title, message: message)
            }
            .eraseToAnyPublisher()
    }
}
