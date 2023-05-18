//
//  AddDeadlineViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 06.05.2023.
//

import Foundation

final class AddDeadlineViewModel: AddDeadlineViewModelViewActionsData {
    var viewActions: AddDeadlineViewModelViewActions
    
    var data: AddDeadlineViewModelData
    
    init() {
        self.viewActions = AddDeadlineViewModelViewActions()
        self.data = AddDeadlineViewModelData()
    }
}

private extension AddDeadlineViewModel {
    func bind() {
        
    }
}
