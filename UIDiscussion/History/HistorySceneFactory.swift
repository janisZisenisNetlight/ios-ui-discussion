import UIKit

class HistorySceneFactory {
    static func makeScene(history: AccountHistory) -> UIViewController {
        let presenter = HistoryPresenter()
        let interactor = HistoryInteractor(presenter: presenter, history: history)
        let viewController = HistoryViewController(interactor: interactor)
        presenter.display = viewController
        
        return viewController
    }
}
