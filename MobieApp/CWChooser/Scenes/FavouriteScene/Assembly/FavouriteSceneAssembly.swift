//
//  FavouriteSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.05.2023.
//

import Foundation
import UIKit

enum FavouriteSceneAssembly {
    static func build() -> UIViewController {
        let viewModel = FavouritesViewModel()
        let viewController = FavouritesViewController(viewModel: viewModel)
        return viewController
    }
}
