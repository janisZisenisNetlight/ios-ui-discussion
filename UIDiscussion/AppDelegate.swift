import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let router = WelcomeSceneFactory().makeScene()
        navigationController.viewControllers = [router.viewController]
        
        return true
    }
}

