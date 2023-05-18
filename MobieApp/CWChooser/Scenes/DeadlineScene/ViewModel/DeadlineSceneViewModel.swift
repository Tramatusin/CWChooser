//
//  DeadlineSceneViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.04.2023.
//

import Foundation
import Combine

final class DeadlineSceneViewModel: DeadlineSceneViewModelViewActionsData {
    var viewActions: DeadlineSceneViewModelViewActions
    
    var data: DeadlineSceneViewModelData
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.viewActions = .init()
        self.data = .init()
        bind()
    }
}

private extension DeadlineSceneViewModel {
    func bind() {
        
    }
}
