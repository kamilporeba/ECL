import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationVC = ECLNavigationVC()
        let cityListVC = CityListViewController(with: navigationVC.viewModel.cityListViewModel)
        navigationVC.viewControllers = [cityListVC]
        window?.rootViewController = navigationVC
        
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
}

