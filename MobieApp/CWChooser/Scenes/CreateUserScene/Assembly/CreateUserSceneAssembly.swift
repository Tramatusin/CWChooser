//
//  CreateUserSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import UIKit

enum CreateUserSceneAssembly {
    
    static func build(navBar: UINavigationController, user: UserModel) -> UIViewController {
        let viewModel = CreateUserViewModel(navBar: navBar, user: user)
        let view = CreateUserViewController(viewModel: viewModel, user: user)
        return view
    }
    
}
