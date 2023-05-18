//
//  MainViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import UIKit
import Combine

typealias MainViewModelProtocol = MainViewModelInputOutput & MainViewModelViewActionsData

final class MainViewModel: MainViewModelProtocol {
    var input: MainViewModelInput
    
    var output: MainViewModelOutput
    
    var viewActions: MainViewModelActions
    
    var data: MainViewModelData
    
    private let navController: UINavigationController
    private var subscription = Set<AnyCancellable>()
    private let projectSendSubject = PassthroughSubject<[Project], Never>()
    private let recomendedProjectSubject = PassthroughSubject<[Project], Never>()
    private let studentProjectsSubject = PassthroughSubject<[Project], Never>()
    private let applicationsSubject = PassthroughSubject<[Application], Never>()
    private let showActivitySubject = PassthroughSubject<Bool, Never>()
    private let networkService: NetworkServiceProtocol
    private let user: UserModel
    private var applications: [Application] = .init()
    
    init(navController: UINavigationController, networkService: NetworkServiceProtocol, user: UserModel) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init(showActivityView: showActivitySubject.eraseToAnyPublisher())
        self.data = .init(
            projectsSendPublisher: projectSendSubject.eraseToAnyPublisher(),
            recomendedProjectsPublisher: recomendedProjectSubject.eraseToAnyPublisher(),
            studentProjectsPublisher: studentProjectsSubject.eraseToAnyPublisher(),
            applicationPublisher: applicationsSubject.eraseToAnyPublisher()
        )
        self.navController = navController
        self.networkService = networkService
        self.user = user
        bind()
    }
}

private extension MainViewModel {
    func bind() {
        viewActions.lifecycle.sink { [weak self] lifecycle in
            switch lifecycle {
            case.didLoad:
                self?.showActivitySubject.send(true)
//                self?.loadApplications()
                self?.loadProjects()
//                self?.loadRecomended()
//                self?.loadEntry()
                self?.showActivitySubject.send(false)
            default:
                return
            }
        }.store(in: &subscription)
        
        viewActions.tapOnProjectCellSubject.sink { [weak self] project, navController in
            guard let self = self else { return }
            let view = ProjectDetailsSceneAssembly.build(
                model: project,
                networkService: self.networkService,
                applications: self.applications,
                user: self.user
            )
            navController.pushViewController(view, animated: true)
//            self?.projectService.getListURLSession(resultTask: ([ProjectService.Project]) -> Void)
        }.store(in: &subscription)
        
        viewActions.tapOnAddButtonSubject.sink { [weak self] navController in
            guard let self = self else { return }
            let view = MainCreateProjectsAssembly.build(networkService: self.networkService)
            navController.pushViewController(view, animated: true)
        }.store(in: &subscription)
        
        viewActions.tapOnProjectsSegmentSubject
            .sink { [weak self] _ in
                self?.showActivitySubject.send(true)
                self?.loadEntry()
                self?.showActivitySubject.send(false)
            }
            .store(in: &subscription)
        
        viewActions.tapOnRecomendedProjectSegment
            .sink { [weak self] _ in
                self?.showActivitySubject.send(true)
                self?.loadRecomended()
                self?.showActivitySubject.send(false)
            }
            .store(in: &subscription)
        
        viewActions.tapOnEntryProjectSegment
            .sink { [weak self] _ in
                self?.showActivitySubject.send(true)
                self?.loadEntry()
                self?.showActivitySubject.send(false)
            }
            .store(in: &subscription)
    }
    
    func loadProjects() {
        networkService.getAllProjects { [weak self] result in
            switch result {
            case .success(let projects):
                self?.projectSendSubject.send(projects)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadRecomended() {
        networkService.recomendedProjects(with: user.id) { [weak self] result in
            switch result {
            case .success(let projects):
                self?.recomendedProjectSubject.send(projects)
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadEntry() {
        networkService.studentProjects(with: user.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let projects):
                self.loadApplications()
                var entryArr: [Project] = []
                for project in projects {
                    for app in self.applications {
                        if project.id == app.project_id, self.user.id == app.student_id, app.status != "Заявка отменена" {
                            entryArr.append(project)
                        }
                    }
                }
                self.studentProjectsSubject.send(entryArr)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadApplications() {
        networkService.getAllApplications { result in
            switch result {
            case .success(let application):
                self.applications = application
            case .failure(let error):
                print(error)
            }
        }
    }
}


