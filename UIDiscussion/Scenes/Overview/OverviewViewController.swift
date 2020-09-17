import UIKit

private extension OverviewViewController {
    enum Constants {
        struct Layout {
            static let insets = NSDirectionalEdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32)
            static let spacingBetweenLabels: CGFloat = 10
            static let spacingBeforeActions: CGFloat = 50
            static let spacingBetweenButtons: CGFloat = 5
            static let borderWidth: CGFloat = 1
            static let cornerRadius: CGFloat = 4
        }
        struct Text {
            static let title = "Account Overview"
            static let firstName = "First Name:"
            static let familyName = "Family Name:"
            static let balance = "Balance:"
            static let withDraw = "Withdraw"
            static let deposit = "Deposit"
            static let showHistory = "Show History"
        }
        struct Color {
            static let background = UIColor.white
            static let border = UIColor.black
            static let buttonBackground = UIColor.lightGray
        }
    }
}

protocol OverviewInteracting {
    func handleViewDidLoad(_ request: OverviewModel.ViewDidLoad.Request)
    func handleWithDraw(_ request: OverviewModel.WithDraw.Request)
    func handleDeposit(_ request: OverviewModel.Deposit.Request)
    func handleRouteToHistory(_ request: OverviewModel.RouteToHistory.Request)
}

class OverviewViewController: UIViewController {
    private let interactor: OverviewInteracting

    private let firstName = UILabel()
    private let familyName = UILabel()
    private let balance = UILabel()
    private let amount = UITextField()
    private let withDraw = UIButton(type: .system)
    private let deposit = UIButton(type: .system)
    private let showHistory = UIButton(type: .system)

    init(interactor: OverviewInteracting) {
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        let request = OverviewModel.ViewDidLoad.Request()
        interactor.handleViewDidLoad(request)
    }
    
    @objc private func onWithDraw() {
        let request = OverviewModel.WithDraw.Request(amount: amount.text ?? "")
        amount.text = nil
        interactor.handleWithDraw(request)
    }
    
    @objc private func onDeposit() {
        let request = OverviewModel.Deposit.Request(amount: amount.text ?? "")
        amount.text = nil
        interactor.handleDeposit(request)
    }

    @objc private func onRouteToHistory() {
        interactor.handleRouteToHistory(.init())
    }
}

extension OverviewViewController: OverviewDisplaying {
    func displayViewDidLoad(_ viewModel: OverviewModel.ViewDidLoad.ViewModel) {
        firstName.text = viewModel.firstName
        familyName.text = viewModel.familyName
        
        updateBalance(viewModel.balance)
    }
    
    func displayWithDraw(_ viewModel: OverviewModel.WithDraw.ViewModel) {
        updateBalance(viewModel.balance)
    }
    
    func displayDeposit(_ viewModel: OverviewModel.Deposit.ViewModel) {
        updateBalance(viewModel.balance)
    }
    
    private func updateBalance(_ viewModel: OverviewModel.BalanceViewModel) {
        balance.text = viewModel.balance
        balance.textColor = viewModel.balanceColor
    }
}

extension OverviewViewController {
    private func setupView() {
        title = Constants.Text.title
        view.directionalLayoutMargins = Constants.Layout.insets
        view.backgroundColor = Constants.Color.background

        let firstNameLabel = UILabel()
        firstNameLabel.text = Constants.Text.firstName
        let familyNameLabel = UILabel()
        familyNameLabel.text = Constants.Text.familyName
        let balanceLabel = UILabel()
        balanceLabel.text = Constants.Text.balance
        amount.layer.borderWidth = Constants.Layout.borderWidth
        amount.layer.borderColor = Constants.Color.border.cgColor
        withDraw.setTitle(Constants.Text.withDraw, for: .normal)
        withDraw.addTarget(self, action: #selector(onWithDraw), for: .primaryActionTriggered)
        withDraw.layer.cornerRadius = Constants.Layout.cornerRadius
        withDraw.layer.borderColor = Constants.Color.border.cgColor
        withDraw.layer.borderWidth = Constants.Layout.borderWidth
        deposit.setTitle(Constants.Text.deposit, for: .normal)
        deposit.addTarget(self, action: #selector(onDeposit), for: .primaryActionTriggered)
        deposit.layer.cornerRadius = Constants.Layout.cornerRadius
        deposit.layer.borderColor = Constants.Color.border.cgColor
        deposit.layer.borderWidth = Constants.Layout.borderWidth
        showHistory.setTitle(Constants.Text.showHistory, for: .normal)
        showHistory.addTarget(self, action: #selector(onRouteToHistory), for: .primaryActionTriggered)
        showHistory.layer.cornerRadius = Constants.Layout.cornerRadius
        showHistory.layer.borderColor = Constants.Color.border.cgColor
        showHistory.layer.borderWidth = Constants.Layout.borderWidth
        
        view.addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstName)
        firstName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(familyNameLabel)
        familyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(familyName)
        familyName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceLabel)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balance)
        balance.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amount)
        amount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(withDraw)
        withDraw.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deposit)
        deposit.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showHistory)
        showHistory.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            firstName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            firstName.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            firstName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            familyNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            familyNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            familyName.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            familyName.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            familyName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            balanceLabel.topAnchor.constraint(equalTo: familyNameLabel.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            balanceLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            balance.topAnchor.constraint(equalTo: familyNameLabel.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            balance.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            balance.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            amount.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: Constants.Layout.spacingBeforeActions),
            amount.heightAnchor.constraint(equalTo: withDraw.heightAnchor),
            amount.widthAnchor.constraint(equalTo: withDraw.widthAnchor),
            amount.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            withDraw.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            deposit.topAnchor.constraint(equalTo: amount.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            withDraw.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            withDraw.trailingAnchor.constraint(equalTo: deposit.leadingAnchor, constant: -Constants.Layout.spacingBetweenButtons),
            deposit.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            deposit.widthAnchor.constraint(equalTo: withDraw.widthAnchor),
            deposit.heightAnchor.constraint(equalTo: withDraw.heightAnchor),
            
            showHistory.topAnchor.constraint(equalTo: withDraw.bottomAnchor, constant: Constants.Layout.spacingBetweenLabels),
            showHistory.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            showHistory.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            showHistory.heightAnchor.constraint(equalTo: withDraw.heightAnchor),
        ])
    }
}
