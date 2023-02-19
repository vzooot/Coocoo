//
//  NotificationView.swift
//  Coocoo
//
//  Created by Administrator on 2/18/23.
//

import Combine
import SwiftUI

struct NotificationView: View {
    @State var viewAdapter: ViewAdapter
    let sendNotificationUseCase: SendNotificationUseCase
    let receiveNotificationUseCase: ReceiveNotificationUseCase

    init(viewAdapter: ViewAdapter = ViewAdapter(),
         sendNotificationUseCase: SendNotificationUseCase = SendNotificationInteractor(),
         receiveNotificationUseCase: ReceiveNotificationUseCase = ReceiveNotificationInteractor())
    {
        _viewAdapter = .init(initialValue: viewAdapter)
        self.sendNotificationUseCase = sendNotificationUseCase
        self.receiveNotificationUseCase = receiveNotificationUseCase
    }

    var body: some View {
        VStack {
            TextField("Title", text: $viewAdapter.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Message", text: $viewAdapter.message)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Send Notification") {
                sendNotification1(title: viewAdapter.title, message: viewAdapter.message)
            }

            Button("Send Notification") {
                sendNotification2(title: viewAdapter.title, message: viewAdapter.message)
            }
            .padding()

            Divider()

            if let notification = viewAdapter.receivedNotification {
                VStack {
                    Text("Received Notification")
                        .font(.headline)
                    Text("Title: \(notification.title)")
                    Text("Message: \(notification.message)")
                }
            } else {
                Text("No notifications received yet")
            }

            if let error = viewAdapter.error {
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            receiveNotification(name: .customNotificationOne)
        }
        .onAppear {
            receiveNotification(name: .customNotificationsTwo)
        }
    }

    // MARK: - Side Effects

    func sendNotification1(title: String, message: String) {
        sendNotificationUseCase.sendNotification(title: title, message: message, name: .customNotificationOne)
    }

    func sendNotification2(title: String, message: String) {
        sendNotificationUseCase.sendNotification(title: title, message: message, name: .customNotificationsTwo)
    }

    func receiveNotification(name: CustomNotificationNames) {
        receiveNotificationUseCase.receivedNotificationPublisher(name: name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    viewAdapter.error = error
                case .finished:
                    break
                }
            }, receiveValue: { notification in
                viewAdapter.receivedNotification = notification
            })
            .store(in: &viewAdapter.cancellables)
    }
}

extension NotificationView {
    struct ViewAdapter {
        var cancellables = Set<AnyCancellable>()
        var receivedNotification: NotificationModel?
        var error: Error?
        var title: String
        var message: String

        init(receivedNotification: NotificationModel? = nil,
             error: Error? = nil,
             title: String = "",
             message: String = "")
        {
            self.receivedNotification = receivedNotification
            self.error = error
            self.title = title
            self.message = message
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
