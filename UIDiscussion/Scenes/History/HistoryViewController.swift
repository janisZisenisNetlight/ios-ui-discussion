import UIKit

private extension HistoryViewController {
    enum Constants {
        struct Text {
            static let title = "Account History"
        }
    }
}

protocol HistoryInteracting {
    func handleViewDidLoad(_ request: HistoryModel.ViewDidLoad.Request)
}

class HistoryViewController: UIViewController {
    private let interactor: HistoryInteracting
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    private var transactions = [HistoryModel.TransactionViewModel]()

    init(interactor: HistoryInteractor) {
        self.interactor = interactor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = Constants.Text.title
        
        interactor.handleViewDidLoad(.init())
    }
}

extension HistoryViewController: HistoryDisplaying {
    func displayViewDidLoad(_ viewModel: HistoryModel.ViewDidLoad.ViewModel) {
        transactions = viewModel.transactions
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryItemCell.reuseIdentifier, for: indexPath) as! HistoryItemCell

        cell.amountText = transactions[indexPath.row].amount
        cell.amountTextColor = transactions[indexPath.row].amountColor
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HistoryViewController {
    private func setupView() {
        tableView.rowHeight = 44
        tableView.register(HistoryItemCell.self, forCellReuseIdentifier: HistoryItemCell.reuseIdentifier)
        
        tableView.dataSource = self
    }
}
