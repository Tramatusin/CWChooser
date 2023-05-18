//
//  CreateProjectsViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 08.03.2023.
//

import Foundation
import Combine

protocol CreateProjectsViewModelViewActionsData {
    var viewActions: CreateProjectsViewModelViewActions { get }
    var data: CreateProjectsViewModelData { get }
}


struct CreateProjectsViewModelViewActions {
    let lifecycleSubject = PassthroughSubject<Lifecycle, Never>()
}

struct CreateProjectsViewModelData {
    let sendProjectModelSubject = PassthroughSubject<ProjectRequest, Never>()
}
