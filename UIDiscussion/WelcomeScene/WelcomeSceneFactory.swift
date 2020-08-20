import UIKit

class WelcomeSceneFactory {
    func makeScene() -> WelcomeRouter {
        let service = WelcomeServiceImp()

        let viewController = WelcomeViewController()
        let router = WelcomeRouter(viewController: viewController)
        let presenter = WelcomePresenter(display: viewController)
        let interactor = WelcomeInteractor(presenter: presenter, router: router, service: service)
        viewController.interactor = interactor

        return router
    }
}
