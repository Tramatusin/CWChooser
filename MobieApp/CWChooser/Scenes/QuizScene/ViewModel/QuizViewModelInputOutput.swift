//
//  QuizViewModelInputOutput.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation

protocol QuizViewModelInputOutput {
    var input: QuizViewModelInput { get }
    
    var output: QuizViewModelOutput { get }
}

struct QuizViewModelInput { }

struct QuizViewModelOutput { }
