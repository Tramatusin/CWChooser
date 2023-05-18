//
//  ProfileHeaderView.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation
import UIKit

final class ProfileHeaderView: UIView {
    private let grid = Grid()
    
    private let typePageLabel: UILabel = {
        let label = UILabel()
        label.text = "СТУДЕНТ"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(named: "HseBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Поволоцкий Виктор Александрович"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let studentGroupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Бакалавриат Группа БПИ196"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteCap")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader(type: String, title: String, subtitle: String, image: UIImage?) {
        typePageLabel.text = type
        nameLabel.text = title
        studentGroupLabel.text = subtitle
        avatarImage.image = image
    }
}

private extension ProfileHeaderView {
    func setupLayout() {
        backgroundColor = UIColor(named: "hseBackground")
        addSubview(nameLabel)
        addSubview(studentGroupLabel)
        addSubview(typePageLabel)
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            typePageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xlargeOffset),
            typePageLabel.topAnchor.constraint(equalTo: topAnchor, constant: grid.xlargeOffset),
            typePageLabel.heightAnchor.constraint(equalToConstant: 17),
            
            nameLabel.leadingAnchor.constraint(equalTo: typePageLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: typePageLabel.bottomAnchor, constant: grid.xlargeOffset),
            nameLabel.widthAnchor.constraint(equalToConstant: 340),
            
            studentGroupLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            studentGroupLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: grid.largeOffset),
            studentGroupLabel.heightAnchor.constraint(equalToConstant: 15),
            studentGroupLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -grid.xxxlargeOffset),

            avatarImage.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            avatarImage.heightAnchor.constraint(equalToConstant: 40),
            avatarImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
