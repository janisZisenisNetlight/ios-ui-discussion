import UIKit

class WelcomeRouter: WelcomeRouting {
    let viewController: UIViewController & WelcomeDisplaying

    init(viewController: UIViewController & WelcomeDisplaying) {
        self.viewController = viewController
    }

    func continueToNextScene() {
    }
}
