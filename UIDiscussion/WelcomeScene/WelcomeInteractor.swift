protocol WelcomePresenting {
    func presentViewDidLoad(_: WelcomeModel.ViewDidLoad.Response)
    func presentViewWillAppear(_: WelcomeModel.ViewWillAppear.Response)
}

protocol WelcomeRouting: AnyObject {
    func continueToNextScene()
}

protocol WelcomeService {
    func fetchTitle() -> WelcomeEntity
}

class WelcomeInteractor: WelcomeInteracting {
    private let presenter: WelcomePresenting
    weak private var router: WelcomeRouting?
    private let service: WelcomeService

    init(presenter: WelcomePresenting, router: WelcomeRouting, service: WelcomeService) {
        self.presenter = presenter
        self.router = router
        self.service = service
    }

    func handleViewDidLoad(_ request: WelcomeModel.ViewDidLoad.Request) {
        let entity = service.fetchTitle()
        let canBeContinued = entity.title.count > 5
        let response = WelcomeModel.ViewDidLoad.Response(
                entity: entity,
                canBeContinued: canBeContinued,
                settingName: entity.settingName,
                settingOff: entity.settingOff
        )
        presenter.presentViewDidLoad(response)
    }

    func handleViewWillAppear(_ request: WelcomeModel.ViewWillAppear.Request) {
        //service.doSomething()
        let response = WelcomeModel.ViewWillAppear.Response()
        presenter.presentViewWillAppear(response)
    }

    func handleContinue(_ request: WelcomeModel.Continue.Request) {
        router?.continueToNextScene()
    }

    func handleSettingsChanged(_: WelcomeModel.SettingsChanged.Request) {
        //service -> presenter
    }
}
