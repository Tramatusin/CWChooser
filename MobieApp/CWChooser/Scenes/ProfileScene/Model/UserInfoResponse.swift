//
//  UserInfoResponse.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.03.2023.
//

import Foundation

public struct UserInfoResponse: Codable {
    let id: Int
    
    let email: String
    
    let faculty: String
    
    let group: String
    
    let name: String
    
    let phone_number: String
    
    let year: Int
}
