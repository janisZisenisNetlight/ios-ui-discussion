import XCTest
@testable import UIDiscussion

class BankAccountSpy: BankAccount {
    var stubbedTransactions: [Double]!
    var stubbedOwner: AccountOwner!
    var stubbedBalance: Double!
    
    private(set) var receivedWithDraw: Double!
    private(set) var receivedDeposit: Double!
    private(set) var invokedWithDraw = false
    private(set) var invokedDeposit = false
    
    var allTransactions: [Double] {
        stubbedTransactions
    }
    
    var owner: AccountOwner {
        stubbedOwner
    }
    
    var balance: Double {
        stubbedBalance
    }
    
    func withDraw(amount: Double) {
        receivedWithDraw = amount
        invokedWithDraw = true
    }
    
    func deposit(amount: Double) {
        receivedDeposit = amount
        invokedDeposit = true
    }
}
