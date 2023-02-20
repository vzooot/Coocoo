//
//  SendNotificationUseCase.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine

protocol SendNotificationUseCase {
    func sendNotification(title: String, message: String, name: CustomNotificationNames)
}

struct SendNotificationInteractor: SendNotificationUseCase {
    let repository: SendNotificationRepository

    init(repository: SendNotificationRepository = SendNotificationDataStore()) {
        self.repository = repository
    }

    func sendNotification(title: String, message: String, name: CustomNotificationNames) {
        repository.sendNotification(title: title, message: message, name: name)
    }
}
