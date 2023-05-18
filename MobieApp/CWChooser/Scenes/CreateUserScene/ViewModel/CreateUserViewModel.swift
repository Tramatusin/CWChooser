//
//  CreateUserViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import Combine
import UIKit

typealias CreateUserViewModelProtocol = CreateUserViewModelViewActionsData & CreateUserViewModelInputOutput

final class CreateUserViewModel: CreateUserViewModelProtocol {
    var viewActions: CreateUserViewModelViewActions
    
    var data: CreateUserViewModelData
    
    var input: CreateUserViewModelInput
    
    var output: CreateUserViewModelOutput
    
    private let networkServive: NetworkServiceProtocol = NetworkService()
    private let navBar: UINavigationController
    private var subscriptions = Set<AnyCancellable>()
    private let user: UserModel
    
    init(navBar: UINavigationController, user: UserModel) {
        self.viewActions = .init()
        self.data = .init()
        self.input = .init()
        self.output = .init()
        self.navBar = navBar
        self.user = user
        bind()
    }
}

private extension CreateUserViewModel {
    func bind() {
        viewActions.tapOnAcceptCell
            .sink { [weak self] userModel in
            guard let self = self else { return }
            self.networkServive.studentInfoCreate(userInfo: userModel) { result in
                switch result {
                case .success(let user):
                    print(user)
                    DispatchQueue.main.async {
                        let view = QuizSceneAssembly.build(navigationController: self.navBar, networkService: self.networkServive, user: self.user)
                        self.navBar.pushViewController(view, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }.store(in: &subscriptions)
    }
}
