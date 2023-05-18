//
//  AuthViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import Foundation
import Combine
import UIKit

typealias AuthViewModelProtocol = AuthViewModelInputOutput & AuthViewModelViewActionsData

final class AuthViewModel: AuthViewModelProtocol {
    var input: AuthViewModelInput = .init()
    
    var output: AuthViewModelOutput
    
    var data: AuthViewModelData
    
    var viewActions: AuthViewModelViewActions
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let showQuizSubject = PassthroughSubject<UIViewController, Never>()
    
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.output = AuthViewModelOutput()
        self.viewActions = AuthViewModelViewActions(showQuizPublisher: showQuizSubject.eraseToAnyPublisher())
        self.data = AuthViewModelData()
        self.navController = navController
        self.bind()
    }
    
    func bind() {
        output.buttonTabSubject.sink { [weak self] user in
            self?.loginOnELK(with: user)
        }.store(in: &subscriptions)
    }
    
    func loginOnELK(with user: UserModel) {
        print("\(user)")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let view = CreateUserSceneAssembly.build(navBar: self.navController, user: user)
            self.navController.pushViewController(view, animated: true)
        }
    }
}
