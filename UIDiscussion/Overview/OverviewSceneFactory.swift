import UIKit

class OverviewSceneFactory {
    static func makeScene(account: BankAccount) -> UIViewController {
        let presenter = OverviewPresenter()
        let router = OverviewRouter()
        let interactor = OverviewInteractor(presenter: presenter, account: account, router: router)
        let viewController = OverviewViewController(interactor: interactor)
        presenter.display = viewController
        router.viewController = viewController
    
        return viewController
    }
}
