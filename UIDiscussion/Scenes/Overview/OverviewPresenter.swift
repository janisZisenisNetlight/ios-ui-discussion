import UIKit

protocol OverviewDisplaying: AnyObject {
    func displayViewDidLoad(_ viewModel: OverviewModel.ViewDidLoad.ViewModel)
    func displayWithDraw(_ viewModel: OverviewModel.WithDraw.ViewModel)
    func displayDeposit(_ viewModel: OverviewModel.Deposit.ViewModel)
}

class OverviewPresenter: OverviewPresenting {
    var display: OverviewDisplaying?
    
    func presentViewDidLoad(_ response: OverviewModel.ViewDidLoad.Response) {
        let viewModel = OverviewModel.ViewDidLoad.ViewModel(
            firstName: response.owner.firstName,
            familyName: response.owner.familyName,
            balance: OverviewModel.BalanceViewModel(response.balance)
        )

        display?.displayViewDidLoad(viewModel)
    }
    
    func presentWithDraw(_ response: OverviewModel.WithDraw.Response) {
        let viewModel = OverviewModel.WithDraw.ViewModel(
            balance: OverviewModel.BalanceViewModel(response.balance)
        )
        display?.displayWithDraw(viewModel)
    }
    
    func presentDeposit(_ response: OverviewModel.Deposit.Response) {
        let viewModel = OverviewModel.Deposit.ViewModel(
            balance: OverviewModel.BalanceViewModel(response.balance)
        )
        display?.displayDeposit(viewModel)
    }
}

private extension OverviewModel.BalanceViewModel {
    init(_ double: Double) {
        balance = double.asEuroString()
        balanceColor = double.asBalanceColor()
    }
}

private extension Double {
    func asBalanceColor() -> UIColor {
        switch self {
        case _ where self < -0.009:
            return UIColor.red
        case _ where self > 0.009:
            return UIColor.green
        default:
            return UIColor.black
        }
    }
    
    func asEuroString() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = "€"

        return currencyFormatter.string(from: self as NSNumber)!
    }
}
