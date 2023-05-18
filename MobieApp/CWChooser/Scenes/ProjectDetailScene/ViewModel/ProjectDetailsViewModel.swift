//
//  ProjectDetailsViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import Combine

typealias ProjectDetailsViewModelProtocol = ProjectDetailsViewModelInputOutput & ProjectsDetailsViewModelViewActionsData

final class ProjectDetailsViewModel: ProjectDetailsViewModelProtocol {
    var input: ProjectDetailsViewModelInput
    
    var output: ProjectDetailsViewModelOutput
    
    var viewActions: ProjectDetailsViewModelViewActions
    
    var data: ProjectDetailsViewModelData
    
//    private let headerDataSubject = PassthroughSubject<HeaderDataModel, Never>()
    private let setEntryStyleSubject = PassthroughSubject<AcceptButtonViewCell.Style, Never>()
    private let setCancelStyleSubject = PassthroughSubject<AcceptButtonViewCell.Style, Never>()
    private let showActivitySubject = PassthroughSubject<Bool, Never>()
    private let dismissActivitySubject = PassthroughSubject<Bool, Never>()
    private var subscription = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    private let projectData: Project
    private var applications: [Application]
    private let user: UserModel
    
    
    init(project: Project, networkService: NetworkServiceProtocol, applications: [Application], user: UserModel) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init(
            setEntryStylePublisher: setEntryStyleSubject.eraseToAnyPublisher(),
            setCancelStylePublisher: setCancelStyleSubject.eraseToAnyPublisher(),
            showActivityView: showActivitySubject.eraseToAnyPublisher(),
            dismissActivityView: dismissActivitySubject.eraseToAnyPublisher()
        )
        self.data = .init()
        self.projectData = project
        self.networkService = networkService
        self.applications = applications
        self.user = user
        bind()
    }
    
    func bind() {
        viewActions.lifeCycleSubject.sink { [weak self] lifecycle in
            guard let self = self else { return }
            switch lifecycle {
            case .didLoad:
                self.showActivitySubject.send(true)
                self.networkService.getAllRequirements(projectId: self.projectData.id) { result in
                    switch result {
                    case .success(let tags):
//                        self.getApplications()
                        let resultStringTags = self.getTagsString(tags: tags)
                        let projectInfo = ProjectData(tags: resultStringTags, projectInfo: self.projectData)
                        var applied = false
                        if let app = self.applications.filter({ $0.project_id == self.projectData.id && $0.student_id == self.user.id}).first {
                            applied = app.status != "Заявка отменена"
                        }
                        self.sendHeaderData()
                        self.data.projectDataSubject.send(projectInfo)
                        self.viewActions.appliedSubject.send(applied)
                        self.dismissActivitySubject.send(false)
                    case .failure(let error):
                        print(error)
                    }
                }
            default: break
            }
        }.store(in: &subscription)
        
        viewActions.tapOnAcceptButton
            .sink { [weak self] projectId in
                guard let self = self else { return }
                let model = EntryOnProjectModel(student_id: self.user.id, project_id: projectId)
                self.networkService.entryOnProject(with: model) { result in
                    switch result {
                    case .success(_):
                        self.setCancelStyleSubject.send(.cancelEntry)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .store(in: &subscription)
        
        viewActions.cancelTapButtonSubject
            .sink { [weak self] projectId in
                guard
                    let self = self
                else { return }
                self.networkService.getAllApplications { result in
                    switch result {
                    case .success(let apps):
                        guard let app = apps.filter({ $0.project_id == projectId && $0.student_id == self.user.id }).first else { return }
                        self.cancelEntry(application: app)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .store(in: &subscription)
    }
}
//guard let app = applications.filter({ $0.project_id == projectId && $0.student_id == self.user.id }).first else { return }
//self.cancelEntry(application: app)

private extension ProjectDetailsViewModel {
    func sendHeaderData() {
        let header = HeaderDataModel(
            type: projectData.project_type,
            title: projectData.title,
            subtitle: projectData.supervisor,
            image: nil
        )
        data.headerDataPublisher.send(header)
    }
    
    func getApplications() {
        self.networkService.getAllApplications { result in
            switch result {
            case .success(let applications):
                self.applications = applications
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cancelEntry(application: Application) {
        networkService.cancelEntryOnProject(
            with: ApplicationRequest(
                project_id: application.project_id,
                student_id: application.student_id,
                status: "Заявка отменена"),
            id: application.id,
            status: "заявка отменена") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(_):
                    self.setEntryStyleSubject.send(.entryOnProject)
                }
            }
    }
    
    func getTagsString(tags: [Tag]) -> String {
        var result = ""
        for item in tags {
            if tags.last?.name == item.name {
                result += item.name
            } else {
                result += item.name + ", "
            }
        }
        return result
    }
}

