class BankAccountImpl: BankAccount {    
    private(set) var id: String
    private(set) var owner: AccountOwner
    private(set) var balance: Double = 0
    private(set) var allTransactions = [Double]()
    
    init(id: String, owner: AccountOwner) {
        self.id = id
        self.owner = owner
    }

    func withDraw(amount: Double) {
        balance -= amount
        store(amount: -amount)
    }
    
    func deposit(amount: Double) {
        balance += amount
        store(amount: amount)
    }
    
    func store(amount: Double) {
        allTransactions.insert(amount, at: 0)
    }
}
