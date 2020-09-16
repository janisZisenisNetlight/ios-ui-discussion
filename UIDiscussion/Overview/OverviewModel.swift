import UIKit

enum OverviewModel {
    struct BalanceViewModel {
        let balance: String
        let balanceColor: UIColor
    }
    
    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
            let owner: AccountOwner
            let balance: Double
        }
        struct ViewModel {
            let firstName: String
            let familyName: String
            let balance: BalanceViewModel
        }
    }
    
    enum WithDraw {
        struct Request {
            let amount: String
        }
        struct Response {
            let balance: Double
        }
        struct ViewModel {
            let balance: BalanceViewModel
        }
    }

    enum Deposit {
        struct Request {
            let amount: String
        }
        struct Response {
            let balance: Double
        }
        struct ViewModel {
            let balance: BalanceViewModel
        }
    }
    
    enum ShowHistory {
        struct Request {
        }
    }
}
