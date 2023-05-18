//
//  AcceptCreateUserCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import UIKit
import Combine

final class AcceptCreateUserCell: UITableViewCell {
    typealias LOC = Localization.QuizViewController
    private let grid = Grid()
    private var tapOnButtonSubject: PassthroughSubject<Void, Never>?
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "HseBlue")
        button.setTitle(LOC.acceptButton, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(tapOnAcceptButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubject(subject: PassthroughSubject<Void, Never>?) {
        self.tapOnButtonSubject = subject
    }
    
    func configureCell(title: String) {
        button.setTitle(title, for: .normal)
    }
}

private extension AcceptCreateUserCell {
    func setupLayout() {
        addSubview(button)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.miniOffset),
            button.topAnchor.constraint(equalTo: topAnchor, constant: grid.xxlargeOffset),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.miniOffset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -grid.xxlargeOffset),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc
    func tapOnAcceptButton() {
        tapOnButtonSubject?.send()
    }
}
