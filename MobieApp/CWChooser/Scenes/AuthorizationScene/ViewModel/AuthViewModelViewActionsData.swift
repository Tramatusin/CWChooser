//
//  AuthViewModelViewActionsData.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import Combine
import UIKit

/// Данные и действия вью
protocol AuthViewModelViewActionsData {
    /// Данные
    var data: AuthViewModelData { get }
    /// Действия вью
    var viewActions: AuthViewModelViewActions { get }
}

struct AuthViewModelViewActions {
//    var setViewPublisher: AnyPublisher<UIView, Never>
    
//    let viewCyclePublisher = PassthroughSubject<Lifecycle, Never>()
    let showQuizPublisher: AnyPublisher<UIViewController, Never>
}

struct AuthViewModelData { }
