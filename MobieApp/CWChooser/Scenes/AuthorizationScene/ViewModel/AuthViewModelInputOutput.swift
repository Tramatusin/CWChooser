//
//  AuthViewModelInputOutput.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import Combine

/// Входные и выходные данные
protocol AuthViewModelInputOutput {
    var input: AuthViewModelInput { get }
    var output: AuthViewModelOutput { get }
}

/// Выходные данные
struct AuthViewModelOutput {
    /// Нажатие на кнопку входа
    var buttonTabSubject = PassthroughSubject<UserModel, Never>()
}

/// Входные данные
struct AuthViewModelInput { }
