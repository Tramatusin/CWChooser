//
//  QuizCheckBoxCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import UIKit

final class QuizCheckBoxCell: UITableViewCell {
    private let grid = Grid()
    
    private let checkedImage = UIImage(named: "check")
    private let uncheckedImage = UIImage(named: "uncheck")
    
    var quizModel: QuizCellModel = QuizCellModel(quiz: QuizModel(id: 1, name: ""), isSelect: false)
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCheckImg() {
        image.image = checkedImage
    }
    
    func setUncheckImg() {
        image.image = uncheckedImage
    }
    
    func configureItem(model: QuizCellModel) {
        self.quizModel = model
        self.titleLabel.text = model.quiz.name
        if model.isSelect {
            setCheckImg()
        } else {
            setUncheckImg()
        }
    }
}
 
private extension QuizCheckBoxCell {
    enum Constants {
        static let sideSize: CGFloat = 25
    }
    
    func setupLayout() {
        addSubview(image)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xxxlargeOffset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: grid.xlargeOffset),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: image.leadingAnchor, constant: -grid.xlargeOffset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -grid.xxxlargeOffset),
            
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: Constants.sideSize),
            image.widthAnchor.constraint(equalToConstant: Constants.sideSize)
        ])
    }
}
