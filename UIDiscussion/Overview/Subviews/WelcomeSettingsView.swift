import UIKit

extension WelcomeSettingsView {
    enum Constants {
        struct Font {
            static let label = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        struct Color {
            static let labelText = UIColor.black
        }
        struct Layout {
            static let spacingBetweenSwitchAndLabel = Spacing.S
        }
    }
}

protocol WelcomeSettingsViewDelegate: AnyObject {
    func onSwitchChanged()
}

class WelcomeSettingsView: UIView {
    weak var delegate: WelcomeSettingsViewDelegate?

    private lazy var settingsSwitch: UISwitch = {
        let settingsSwitch = UISwitch()
        settingsSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return settingsSwitch
    }()

    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.label
        label.textColor = Constants.Color.labelText
        return label
    }()

    var title: String? {
        get {
            return settingsLabel.text
        }
        set {
            settingsLabel.text = newValue
        }
    }

    var isOff: Bool {
        get {
            return !settingsSwitch.isOn
        }
        set {
            settingsSwitch.isOn = !newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    @objc private func switchChanged() {
        delegate?.onSwitchChanged()
    }
}

extension WelcomeSettingsView {
    func setupView() {
        addSubviewsForAutolayout(settingsLabel, settingsSwitch)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
            settingsLabel.leadingAnchor.constraint(equalTo: settingsSwitch.trailingAnchor, constant: Constants.Layout.spacingBetweenSwitchAndLabel),
            settingsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            settingsSwitch.topAnchor.constraint(equalTo: topAnchor),
            settingsSwitch.bottomAnchor.constraint(equalTo: bottomAnchor),
            settingsSwitch.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
