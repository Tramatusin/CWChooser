//
//  ProfileSceneAssembly.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 26.02.2023.
//

import Foundation

enum ProfileSceneAssembly {
    static func build(networkService: NetworkServiceProtocol, user: UserModel) -> ProfileViewController {
        let viewModel = ProfileViewModel(networkService: networkService, user: user)
        let view = ProfileViewController(viewModel: viewModel)
        return view
    }
}
