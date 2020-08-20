import UIKit

private extension WelcomeViewController {
    enum Constants {
        struct Text {
            static let title = "Welcome iOS Crew!"
        }
    }
}

protocol WelcomeInteracting {
    func handleViewDidLoad(_ request: WelcomeModel.ViewDidLoad.Request)
    func handleViewWillAppear(_ request: WelcomeModel.ViewWillAppear.Request)
    func handleContinue(_ request: WelcomeModel.Continue.Request)
    func handleSettingsChanged(_: WelcomeModel.SettingsChanged.Request)
}

class WelcomeViewController: UIViewController {
    var interactor: WelcomeInteracting?

    private lazy var welcomeView: WelcomeView = {
        let view = WelcomeView()
        view.delegate = self
        return view
    }()

    override func loadView() {
        view = welcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Text.title

        let request = WelcomeModel.ViewDidLoad.Request()
        interactor?.handleViewDidLoad(request)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let request = WelcomeModel.ViewWillAppear.Request()
        interactor?.handleViewWillAppear(request)
    }
}

extension WelcomeViewController: WelcomeDisplaying {
    func displayViewDidLoad(_ viewModel: WelcomeModel.ViewDidLoad.ViewModel) {
        //update UI

        welcomeView.title = viewModel.title
        welcomeView.isContinueButtonEnabled = viewModel.isContinueButtonEnabled
        welcomeView.settingsTitle = viewModel.settingName
        welcomeView.isSettingOff = viewModel.settingOff
    }

    func displayViewWillAppear(_ viewModel: WelcomeModel.ViewWillAppear.ViewModel) {
        //update UI
    }
}

extension WelcomeViewController: WelcomeViewDelegate {
    func onContinueTouched() {
        let request = WelcomeModel.Continue.Request()
        interactor?.handleContinue(request)
    }

    func settingsChanged() {
        let request = WelcomeModel.SettingsChanged.Request(newSettingState: welcomeView.isSettingOff)
        interactor?.handleSettingsChanged(request)
    }
}
