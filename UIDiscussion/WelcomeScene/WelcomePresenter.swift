protocol WelcomeDisplaying: AnyObject {
    func displayViewDidLoad(_: WelcomeModel.ViewDidLoad.ViewModel)
    func displayViewWillAppear(_: WelcomeModel.ViewWillAppear.ViewModel)
}

class WelcomePresenter: WelcomePresenting {
    weak private var display: WelcomeDisplaying?

    init(display: WelcomeDisplaying) {
        self.display = display
    }

    func presentViewDidLoad(_ response: WelcomeModel.ViewDidLoad.Response) {
        let viewModel = WelcomeModel.ViewDidLoad.ViewModel(
                title: response.entity.title,
                isContinueButtonEnabled: response.canBeContinued,
                settingName: response.settingName,
                settingOff: response.settingOff
        )

        display?.displayViewDidLoad(viewModel)
    }

    func presentViewWillAppear(_ response: WelcomeModel.ViewWillAppear.Response) {
        let viewModel = WelcomeModel.ViewWillAppear.ViewModel()
        display?.displayViewWillAppear(viewModel)
    }
}
