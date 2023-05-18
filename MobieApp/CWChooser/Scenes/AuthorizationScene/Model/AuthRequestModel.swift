//
//  AuthRequestModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import Foundation

public struct AuthRequestModel: Codable {
    let login: String
    let password: String
}
