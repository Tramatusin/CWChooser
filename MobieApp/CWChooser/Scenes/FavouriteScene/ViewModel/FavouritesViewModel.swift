//
//  FavouritesViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 06.05.2023.
//

import Foundation

final class FavouritesViewModel: FavouritesViewModelViewActionsData {
    var viewActions: FavouritesViewModelViewActions
    
    var data: FavoutritesViewModelData
    
    init() {
        self.viewActions = FavouritesViewModelViewActions()
        self.data = FavoutritesViewModelData()
    }
}

private extension FavouritesViewModel {
    func bind() {
    
    }
}
