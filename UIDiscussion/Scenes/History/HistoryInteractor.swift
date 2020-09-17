import Foundation

protocol HistoryPresenting {
    func presentViewDidLoad(_ response: HistoryModel.ViewDidLoad.Response)
}

protocol AccountHistory: AnyObject {
    var allTransactions: [Double] { get }
}

class HistoryInteractor: HistoryInteracting {
    private let presenter: HistoryPresenting
    private let history: AccountHistory

    init(presenter: HistoryPresenting, history: AccountHistory) {
        self.presenter = presenter
        self.history = history
    }
    
    func handleViewDidLoad(_ request: HistoryModel.ViewDidLoad.Request) {
        let response = HistoryModel.ViewDidLoad.Response(transactions: history.allTransactions)
        presenter.presentViewDidLoad(response)
    }
}
