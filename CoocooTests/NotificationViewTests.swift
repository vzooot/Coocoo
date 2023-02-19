//
//  NotificationViewTests.swift
//  CoocooTests
//
//  Created by Administrator on 2/18/23.
//

import Combine
import XCTest

@testable import Coocoo

final class NotificationViewTests: XCTestCase {
    var view: NotificationView!
    var sendNotificationUseCase: MockSendNotificationUseCase!
    var receiveNotificationUseCase: MockReceiveNotificationUseCase!

    override func setUp() {
        super.setUp()

        sendNotificationUseCase = MockSendNotificationUseCase()
        receiveNotificationUseCase = MockReceiveNotificationUseCase()

        view = NotificationView(
            viewAdapter: NotificationView.ViewAdapter(
                title: "test title",
                message: "test message"
            ),
            sendNotificationUseCase: sendNotificationUseCase,
            receiveNotificationUseCase: receiveNotificationUseCase
        )
    }

    func testSendNotification() {
        view.sendNotification(title: "new title", message: "new message")
        XCTAssertTrue(sendNotificationUseCase.sendNotificationCalled)
        XCTAssertEqual(sendNotificationUseCase.sendNotificationTitle, "new title")
        XCTAssertEqual(sendNotificationUseCase.sendNotificationMessage, "new message")
    }

    func testReceiveNotification() {
        // Given
        let expectation = XCTestExpectation(description: "Notification received")
        expectation.assertForOverFulfill = true
        let expectedModel = NotificationModel(title: "Test Notification", message: "This is a test notification")
        let notification = Notification(name: Notification.Name("TestNotification"),
                                         object: nil,
                                         userInfo: ["title": "Test Notification", "message": "This is a test notification"])
        let notificationPublisher = Just(notification).eraseToAnyPublisher()
        let repository = ReceiveNotificationRepositoryMock()
        repository.receivedNotificationPublisherReturnValue = notificationPublisher
        let interactor = ReceiveNotificationInteractor(repository: repository)
        
        // When
        let cancellable = interactor.receivedNotificationPublisher()
            .sink { receivedModel in
                // Then
                XCTAssertEqual(receivedModel, expectedModel)
                expectation.fulfill()
            }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
        
        // Cancel the publisher
        cancellable.cancel()
        
        // Verify that the repository method was called
        XCTAssertEqual(repository.receivedNotificationPublisherCallCount, 1)
    }


    func testReceiveNotificationError() {
        receiveNotificationUseCase.shouldFail = true
        let expectation = XCTestExpectation(description: "Error received")
        view.viewAdapter.error = nil

        view.receiveNotification()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let error = self.view.viewAdapter.error {
                // Test failed with error message
                XCTFail("Error received: \(error)")
            } else {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

}

class MockSendNotificationUseCase: SendNotificationUseCase {
    var sendNotificationCalled = false
    var sendNotificationTitle: String?
    var sendNotificationMessage: String?

    func sendNotification(title: String, message: String) {
        sendNotificationCalled = true
        sendNotificationTitle = title
        sendNotificationMessage = message
    }
}

class MockReceiveNotificationUseCase: ReceiveNotificationUseCase {
    var shouldFail = false
    var notificationSubject = PassthroughSubject<NotificationModel, Never>()

    func receivedNotificationPublisher() -> AnyPublisher<NotificationModel, Never> {
        if shouldFail {
            return Empty<NotificationModel, Never>(completeImmediately: true).eraseToAnyPublisher()
        } else {
            return notificationSubject.eraseToAnyPublisher()
        }
    }
}


class ReceiveNotificationRepositoryMock: ReceiveNotificationRepository {
    var receivedNotificationPublisherCallCount = 0
    var receivedNotificationPublisherReturnValue: AnyPublisher<Notification, Never>!

    func receivedNotificationPublisher() -> AnyPublisher<Notification, Never> {
        receivedNotificationPublisherCallCount += 1
        return receivedNotificationPublisherReturnValue
    }
}
