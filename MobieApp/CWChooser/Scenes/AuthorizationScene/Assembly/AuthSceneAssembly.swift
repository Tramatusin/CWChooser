//
//  AuthSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import UIKit

enum AuthSceneAssembly {
    static func build(navigationController: UINavigationController) -> AuthorizationViewController {
        let viewModel =  AuthViewModel(navController: navigationController)
        let view = AuthorizationViewController(viewModel: viewModel)
        return view
    }
}
 
