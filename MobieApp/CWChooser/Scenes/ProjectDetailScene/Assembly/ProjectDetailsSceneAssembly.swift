//
//  ProjectDetailsSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit

enum ProjectDetailsSceneAssembly {
    static func build(model: Project, networkService: NetworkServiceProtocol, applications: [Application], user: UserModel) -> ProjectDetailsViewController {
        let viewModel =  ProjectDetailsViewModel(
            project: model,
            networkService: networkService,
            applications: applications,
            user: user
        )
        let view = ProjectDetailsViewController(viewModel: viewModel)
        return view
    }
}
