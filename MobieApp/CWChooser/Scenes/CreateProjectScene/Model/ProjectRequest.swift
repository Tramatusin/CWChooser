//
//  ProjectRequest.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 22.03.2023.
//

import Foundation

public struct ProjectRequest: Codable {
    let title: String
    let description: String
    let project_type: String
    let supervisor: String
    let number_of_students: Int
    let submission_deadline: String
    let application_deadline: String
    let application_form: String
    let status: String
}
