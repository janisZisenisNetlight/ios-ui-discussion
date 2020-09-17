import UIKit

extension HistoryItemCell {
    static let reuseIdentifier = "HistoryItemCellIdentifier"
}

private extension HistoryItemCell {
    enum Constants {
        struct Text {
            static let amount = "Amount:"
        }
    }
}

class HistoryItemCell: UITableViewCell {
    private let amount = UILabel()
    
    var amountText: String? {
        get {
            return amount.text
        }
        set {
            amount.text = newValue
        }
    }
    
    var amountTextColor: UIColor? {
        get {
            return amount.textColor
        }
        set {
            amount.textColor = newValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        amountText = nil
        amountTextColor = nil
    }
}

extension HistoryItemCell {
    private func setupView() {
        let amountLabel = UILabel()
        amountLabel.text = Constants.Text.amount
        
        addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amount)
        amount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: topAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            amount.topAnchor.constraint(equalTo: topAnchor),
            amount.bottomAnchor.constraint(equalTo: bottomAnchor),
            amount.leadingAnchor.constraint(equalTo: centerXAnchor),
            amount.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
}
