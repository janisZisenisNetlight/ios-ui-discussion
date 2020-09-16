import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        router = Router(navigationController: navigationController)
        router?.showOverview()
        
        return true
    }
}

