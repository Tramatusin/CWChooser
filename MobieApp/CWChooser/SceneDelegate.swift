//
//  SceneDelegate.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
//        let mainTabBar = UITabBarController(
        let navController = UINavigationController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backgroundColor = UIColor(named: "hseNavBar")
        navController.navigationBar.standardAppearance = appearance;
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        let authController = AuthSceneAssembly.build(navigationController: navController)
//        navController.setViewControllers([authController], animated: true)
        let vc = DeadlineSceneViewController(viewModel: DeadlineSceneViewModel())
        let vm = ProfileViewModel(networkService: NetworkService(), user: UserModel(id: 14, username: "arteezycat@gmail.com"))
        let favourites = FavouritesViewController(viewModel: FavouritesViewModel())
        let profileController = ProfileViewController(viewModel: vm)
        let addDeadline = AddDeadlineViewController(viewModel: AddDeadlineViewModel())
        navController.setViewControllers([authController], animated: true)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setRootViewController(_ vc: UIViewController, _ userId: Int? = nil) {
         if let window = self.window {
              // if we are logging in, pass the userId
              if let customTb = vc as? UITabBarController {
//                   customTb.userId = userId
                  print("castom vc \(customTb)")
              }
              window.rootViewController = vc
         }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

