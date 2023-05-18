//
//  ProjectsDetailsViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import Combine

protocol ProjectsDetailsViewModelViewActionsData {
    var viewActions: ProjectDetailsViewModelViewActions { get }
    
    var data: ProjectDetailsViewModelData { get }
}

struct ProjectDetailsViewModelViewActions {
    let lifeCycleSubject = PassthroughSubject<Lifecycle, Never>()
    
    let tapOnAcceptButton = PassthroughSubject<Int, Never>()
    
    let cancelTapButtonSubject = PassthroughSubject<Int, Never>()
    
    let appliedSubject = PassthroughSubject<Bool, Never>()
    
    let setEntryStylePublisher: AnyPublisher<AcceptButtonViewCell.Style, Never>
    
    let setCancelStylePublisher: AnyPublisher<AcceptButtonViewCell.Style, Never>
    
    let showActivityView: AnyPublisher<Bool, Never>
    
    let dismissActivityView: AnyPublisher<Bool, Never>
}

struct ProjectDetailsViewModelData {
    let headerDataPublisher = PassthroughSubject<HeaderDataModel, Never>()
    
    let projectDataSubject = PassthroughSubject<ProjectData,Never>()
}
