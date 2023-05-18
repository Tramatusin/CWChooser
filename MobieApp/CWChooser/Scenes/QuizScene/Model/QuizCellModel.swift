//
//  QuizCellModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.03.2023.
//

import Foundation

class QuizCellModel {
    
    init(quiz: QuizModel, isSelect: Bool) {
        self.quiz = quiz
        self.isSelect = isSelect
    }
    
    let quiz: QuizModel
    
    var isSelect: Bool
}
