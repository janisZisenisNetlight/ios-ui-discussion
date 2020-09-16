import UIKit

class Router {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showOverview() {
        let account = BankAccountImpl(
            id: "1234",
            owner: AccountOwner(firstName: "Janis", familyName: "Zisenis")
        )

        let viewController = OverviewSceneFactory.makeScene(router: self, account: account)
        navigationController.viewControllers = [viewController]
    }
}

extension Router: OverviewRouting {
    func routeToHistory(history: AccountHistory) {
        let viewController = HistorySceneFactory.makeScene(history: history)
        navigationController.pushViewController(viewController, animated: true)
    }
}

