import XCTest
@testable import UIDiscussion

class OverviewRoutingSpy: OverviewRouting {
    private(set) var receivedHistory: AccountHistory!
    
    func routeToHistory(history: AccountHistory) {
        receivedHistory = history
    }
}
