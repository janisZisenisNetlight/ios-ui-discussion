import UIKit

protocol HistoryDisplaying: AnyObject {
    func displayViewDidLoad(_ viewModel: HistoryModel.ViewDidLoad.ViewModel)
}

class HistoryPresenter: HistoryPresenting {
    var display: HistoryDisplaying?
    
    func presentViewDidLoad(_ response: HistoryModel.ViewDidLoad.Response) {
        let transactions = response.transactions.map { HistoryModel.TransactionViewModel($0) }
        let viewModel = HistoryModel.ViewDidLoad.ViewModel(transactions: transactions)
        display?.displayViewDidLoad(viewModel)
    }
}

private extension HistoryModel.TransactionViewModel {
    init(_ double: Double) {
        amount = double.asEuroString()
        amountColor = double.asBalanceColor()
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
