//
//  Project.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 13.03.2023.
//

import Foundation

public struct Project: Codable {
    let id: Int
    let title: String
    let description: String
    let project_type: String
    let supervisor: String
    let number_of_students: Int
    let submission_deadline: String
    let application_deadline: String
    let application_form: String
    let status: String
    
    struct DescriptionModel {
        let title: String
        
        let description: String
        
        let superVisior: String
        
        let numberOfStudents: String
    }
    
    struct SegmentDateModel {
        enum TypeProject: String {
            case research = "Исследовательская"
            case praktic = "Практическая"
        }
        
        let projectType: String
        
        let submissionDate: Date
        
        let applicationDate: Date
    }
}
