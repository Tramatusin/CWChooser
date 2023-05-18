//
//  CreateUserViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import Combine

protocol CreateUserViewModelViewActionsData {
    var viewActions: CreateUserViewModelViewActions { get }
    var data: CreateUserViewModelData { get }
}

struct CreateUserViewModelViewActions {
    let tapOnAcceptCell = PassthroughSubject<UserInfoModel, Never>()
}

struct CreateUserViewModelData {}
