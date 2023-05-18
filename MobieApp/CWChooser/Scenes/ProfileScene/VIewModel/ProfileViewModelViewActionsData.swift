//
//  ProfileViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation
import Combine

protocol ProfileViewModelViewActionsData {
    var viewActions: ProfileViewModelViewActions { get }
    
    var data: ProfileViewModelData { get }
}

struct ProfileViewModelViewActions {
    let lifecycle = PassthroughSubject<Lifecycle, Never>()
}

struct ProfileViewModelData {
    let userInfoDataSubject: AnyPublisher<UserInfoResponse, Never>
    
    let userInterestsSubject: AnyPublisher<String, Never>
}
