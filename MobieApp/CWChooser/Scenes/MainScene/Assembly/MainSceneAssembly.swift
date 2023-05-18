//
//  MainSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 24.02.2023.
//

import Foundation
import UIKit

enum MainSceneAssembly {
    static func build(navigationController: UINavigationController, networkService: NetworkServiceProtocol, user: UserModel) -> MainViewController {
        let viewModel =  MainViewModel(navController: navigationController, networkService: networkService, user: user)
        let view = MainViewController(viewModel: viewModel)
        return view
    }
}
