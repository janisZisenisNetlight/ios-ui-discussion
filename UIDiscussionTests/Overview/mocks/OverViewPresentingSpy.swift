import XCTest
@testable import UIDiscussion

class OverViewPresentingSpy: OverviewPresenting {
    private(set) var receivedViewDidLoadResponse: OverviewModel.ViewDidLoad.Response!
    private(set) var receivedWithDrawResponse: OverviewModel.WithDraw.Response!
    private(set) var receivedDepositResponse: OverviewModel.Deposit.Response!
    private(set) var invokedPresentViewDidLoad = false
    private(set) var invokedPresentWithDraw = false
    private(set) var invokedPresentDeposit = false
    
    func presentViewDidLoad(_ response: OverviewModel.ViewDidLoad.Response) {
        receivedViewDidLoadResponse = response
        invokedPresentViewDidLoad = true
    }
    
    func presentWithDraw(_ response: OverviewModel.WithDraw.Response) {
        receivedWithDrawResponse = response
        invokedPresentWithDraw = true
    }
    
    func presentDeposit(_ response: OverviewModel.Deposit.Response) {
        receivedDepositResponse = response
        invokedPresentDeposit = true
    }
}
