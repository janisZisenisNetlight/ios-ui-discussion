import UIKit

enum HistoryModel {
    struct TransactionViewModel{
        let amount: String
        let amountColor: UIColor
    }
    
    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
            let transactions: [Double]
        }
        struct ViewModel {
            let transactions: [TransactionViewModel]
        }
    }
}
