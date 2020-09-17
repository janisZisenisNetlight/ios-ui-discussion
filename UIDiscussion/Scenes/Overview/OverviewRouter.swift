import UIKit

class OverviewRouter: OverviewRouting {
    weak var viewController: UIViewController?

    func routeToHistory(history: AccountHistory) {
        let destinationVC = HistorySceneFactory.makeScene(history: history)
        viewController?.show(destinationVC, sender: nil)
    }
}
