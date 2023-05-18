//
//  ProjectThemeModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation

struct ProjectThemeModel: Codable {
    let projectName: String
    
    let teacherName: String
    
    let projectSectionName: String
    
    let deadlineTime: String
    
    var isFavourite: Bool
    
    struct Teacher {
        let name: String
        
        let departement: String
    }
}
