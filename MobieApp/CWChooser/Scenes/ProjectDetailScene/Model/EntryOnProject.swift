//
//  EntryOnProject.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 21.03.2023.
//

import Foundation

public struct EntryOnProjectModel: Codable {
    let student_id: Int
    
    let project_id: Int
    
    let status: String = "Подана заявка"
}
