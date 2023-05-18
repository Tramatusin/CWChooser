//
//  ProfileViewModelInputOutput.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation

protocol ProfileViewModelInputOutput {
    var input: ProfileViewModelInput { get }
    
    var output: ProfileViewModelOutput { get }
}

struct ProfileViewModelInput {}

struct ProfileViewModelOutput {}
