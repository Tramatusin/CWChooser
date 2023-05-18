//
//  DeadlineSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 18.04.2023.
//

import Foundation
import UIKit

enum DeadlineSceneAssembly {
    static func buildMain() -> UIViewController {
        let viewModel = DeadlineSceneViewModel()
        let viewController = DeadlineSceneViewController(viewModel: viewModel)
        return viewController
    }
    
    static func buildAdd() -> UIViewController {
        let viewModel = AddDeadlineViewModel()
        let viewController = AddDeadlineViewController(viewModel: viewModel)
        return viewController
    }
}
