import XCTest
@testable import UIDiscussion

class OverviewDisplayingSpy: OverviewDisplaying {
    private(set) var invokedDisplayViewDidLoad: Bool = false
    private(set) var invokedDisplayWithDraw: Bool = false
    private(set) var invokedDisplayDeposit: Bool = false
    
    private(set) var receivedViewDidLoadViewModel: OverviewModel.ViewDidLoad.ViewModel!
    private(set) var receivedWithDrawViewModel: OverviewModel.WithDraw.ViewModel!
    private(set) var receivedDepositViewModel: OverviewModel.Deposit.ViewModel!
    
    func displayViewDidLoad(_ viewModel: OverviewModel.ViewDidLoad.ViewModel) {
        invokedDisplayViewDidLoad = true
        receivedViewDidLoadViewModel = viewModel
    }
    
    func displayWithDraw(_ viewModel: OverviewModel.WithDraw.ViewModel) {
        invokedDisplayWithDraw = true
        receivedWithDrawViewModel = viewModel
    }
    
    func displayDeposit(_ viewModel: OverviewModel.Deposit.ViewModel) {
        invokedDisplayDeposit = true
        receivedDepositViewModel = viewModel
    }
}
