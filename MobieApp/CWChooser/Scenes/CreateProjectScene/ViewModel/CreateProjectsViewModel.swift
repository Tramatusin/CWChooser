//
//  CreateProjectsViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 08.03.2023.
//

import Foundation
import Combine

typealias CreateProjectsViewModelProtocol = CreateProjectsViewModelViewActionsData & CreateProjectsViewModelInputOutput

final class CreateProjectsViewModel: CreateProjectsViewModelProtocol {
    var viewActions: CreateProjectsViewModelViewActions
    
    var data: CreateProjectsViewModelData
    
    var input: CreateProjectsViewModelInput
    
    var output: CreateProjectsViewModelOutput
    
    private var subscriptions = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.viewActions = .init()
        self.data = .init()
        self.input = .init()
        self.output = .init()
        self.networkService = networkService
        bind()
    }
}

private extension CreateProjectsViewModel {
    func bind() {
        data.sendProjectModelSubject
            .sink { [weak self] project in
                self?.createProject(project: project)
            }
            .store(in: &subscriptions)
    }
    
    func createProject(project: ProjectRequest) {
        networkService.createProject(with: project) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
