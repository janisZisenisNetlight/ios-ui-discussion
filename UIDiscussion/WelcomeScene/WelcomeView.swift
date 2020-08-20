import UIKit

extension WelcomeView {
    private enum Constants {
        struct Font {
            static let title = UIFont.systemFont(ofSize: 24, weight: .medium)
        }
        struct Text {
            static let buttonTitle = "Continue"
        }
        struct Color {
            static let background = AppColor.lightShadowBlue
            static let title = AppColor.brownTextColor
            static let buttonBackground = AppColor.pastelBlue
        }
        struct Layout {
            static let insets = UIEdgeInsets(top: Spacing.M, left: Spacing.S, bottom: Spacing.M, right: Spacing.S)
            static let buttonHeight: CGFloat = 50
            static let buttonCornerRadius: CGFloat = 4
            static let spacingBetweenLabelAndButton = Spacing.L
            static let spacingBetweenButtonAndSettings = Spacing.M
        }
    }
}

protocol WelcomeViewDelegate: AnyObject {
    func onContinueTouched()
    func settingsChanged()
}

class WelcomeView: UIView {
    weak var delegate: WelcomeViewDelegate?

    private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.Font.title
        label.textColor = Constants.Color.title
        return label
    }()

    private var continueButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onContinueTouched), for: .primaryActionTriggered)
        button.setTitle(Constants.Text.buttonTitle, for: .normal)
        button.backgroundColor = Constants.Color.buttonBackground
        button.layer.cornerRadius = Constants.Layout.buttonCornerRadius
        return button
    }()

    private lazy var settingsView: WelcomeSettingsView = {
        let settingsView = WelcomeSettingsView()
        settingsView.delegate = self
        return settingsView
    }()

    var settingsTitle: String? {
        get {
            return settingsView.title
        }
        set {
            settingsView.title = newValue
        }
    }

    var isSettingOff: Bool {
        get {
            return settingsView.isOff
        }
        set {
            settingsView.isOff = newValue
        }
    }

    var isContinueButtonEnabled: Bool {
        get {
            return continueButton.isEnabled
        }
        set {
            continueButton.isEnabled = newValue
        }
    }

    var title: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
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

    @objc func onContinueTouched() {
        delegate?.onContinueTouched()
    }
}

extension WelcomeView: WelcomeSettingsViewDelegate {
    func onSwitchChanged() {
        delegate?.settingsChanged()
    }
}

extension WelcomeView {
    func setupView() {
        layoutMargins = Constants.Layout.insets
        backgroundColor = Constants.Color.background

        addSubviewsForAutolayout(label, continueButton, settingsView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: Constants.Layout.spacingBetweenLabelAndButton),
            continueButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.Layout.buttonHeight)
        ])

        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: Constants.Layout.spacingBetweenButtonAndSettings),
            settingsView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}
