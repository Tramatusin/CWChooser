//
//  ApplicationModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 27.03.2023.
//

import Foundation

struct Application: Codable {
    let id: Int
    let project_id: Int
    let student_id: Int
    let status: String
}

struct ApplicationRequest: Codable {
    let project_id: Int
    let student_id: Int
    let status: String
}
