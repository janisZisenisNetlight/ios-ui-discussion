import UIKit

class OverviewSceneFactory {
    static func makeScene(router: OverviewRouting, account: BankAccount) -> UIViewController {
        let presenter = OverviewPresenter()
        let interactor = OverviewInteractor(presenter: presenter, account: account, router: router)
        let viewController = OverviewViewController(interactor: interactor)
        presenter.display = viewController
    
        return viewController
    }
}
