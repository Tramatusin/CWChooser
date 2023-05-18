//
//  ProjectDetailsViewModelInputOutput.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation

protocol ProjectDetailsViewModelInputOutput {
    var input: ProjectDetailsViewModelInput { get }
    
    var output: ProjectDetailsViewModelOutput { get }
}

struct ProjectDetailsViewModelInput {}

struct ProjectDetailsViewModelOutput {}
