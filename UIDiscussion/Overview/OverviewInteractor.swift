import Foundation

protocol OverviewPresenting {
    func presentViewDidLoad(_ response: OverviewModel.ViewDidLoad.Response)
    func presentWithDraw(_ response: OverviewModel.WithDraw.Response)
    func presentDeposit(_ response: OverviewModel.Deposit.Response)
}

protocol BankAccount: AccountHistory {
    var owner: AccountOwner { get }
    var balance: Double { get }
    func withDraw(amount: Double)
    func deposit(amount: Double)
}

class OverviewInteractor: OverviewInteracting {
    private let presenter: OverviewPresenting
    private let account: BankAccount
    private let router: OverviewRouting

    init(presenter: OverviewPresenting, account: BankAccount, router: OverviewRouting) {
        self.presenter = presenter
        self.account = account
        self.router = router

    }

    func handleViewDidLoad(_ request: OverviewModel.ViewDidLoad.Request) {
        let response = OverviewModel.ViewDidLoad.Response(owner: account.owner, balance: account.balance)
        presenter.presentViewDidLoad(response)
    }
    
    func handleWithDraw(_ request: OverviewModel.WithDraw.Request) {
        guard let amount = request.amount.asDouble() else {
            return
        }

        account.withDraw(amount: amount)

        let response = OverviewModel.WithDraw.Response(balance: account.balance)
        presenter.presentWithDraw(response)
    }
    
    func handleDeposit(_ request: OverviewModel.Deposit.Request) {
        guard let amount = request.amount.asDouble() else {
            return
        }
    
        account.deposit(amount: amount)
        
        let response = OverviewModel.Deposit.Response(balance: account.balance)
        presenter.presentDeposit(response)
    }

    func handleRouteToHistory(_ request: OverviewModel.RouteToHistory.Request) {
        router.routeToHistory(history: account)
    }
}

private extension String {
    func asDouble() -> Double? {
        guard let double = (self as NSString?)?.doubleValue else {
            return nil
        }
        
        return double > 0 ? double: nil
    }
}
