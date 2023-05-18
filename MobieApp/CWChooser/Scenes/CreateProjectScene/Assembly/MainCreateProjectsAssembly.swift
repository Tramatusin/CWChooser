//
//  MainCreateProjectsAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.03.2023.
//

import Foundation
import UIKit

enum MainCreateProjectsAssembly {
    static func build(networkService: NetworkServiceProtocol) -> UIViewController {
        let viewModel = CreateProjectsViewModel(networkService: networkService)
        let view = CreateProjectsViewController(viewModel: viewModel)
        return view
    }
}
