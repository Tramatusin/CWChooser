//
//  UserInfoModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation

public struct UserInfoModel: Codable {
    
    let student_id: Int
    
    let name: String
    
    let group: String
    
    let faculty: String
    
    let year: Int
    
    let phone_number: String
}
