//
//  TestKhulnaSoft.swift
//  KhulnaSoftTests
//
//  Created by Ben White on 22.03.23.
//

import Foundation
import KhulnaSoft
import XCTest

func getBatchedEvents(_ server: MockKhulnaSoftServer, timeout: TimeInterval = 15.0, failIfNotCompleted: Bool = true) -> [KhulnaSoftEvent] {
    let result = XCTWaiter.wait(for: [server.batchExpectation!], timeout: timeout)

    if result != XCTWaiter.Result.completed, failIfNotCompleted {
        XCTFail("The expected requests never arrived")
    }

    var events: [KhulnaSoftEvent] = []
    for request in server.batchRequests.reversed() {
        let items = server.parseKhulnaSoftEvents(request)
        events.append(contentsOf: items)
    }

    return events
}

func waitDecideRequest(_ server: MockKhulnaSoftServer) {
    let result = XCTWaiter.wait(for: [server.decideExpectation!], timeout: 15)

    if result != XCTWaiter.Result.completed {
        XCTFail("The expected requests never arrived")
    }
}

func getDecideRequest(_ server: MockKhulnaSoftServer) -> [[String: Any]] {
    waitDecideRequest(server)

    var requests: [[String: Any]] = []
    for request in server.decideRequests.reversed() {
        let item = server.parseRequest(request, gzip: false)
        requests.append(item!)
    }

    return requests
}
