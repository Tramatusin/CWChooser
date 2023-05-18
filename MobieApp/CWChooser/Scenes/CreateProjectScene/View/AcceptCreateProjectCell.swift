//
//  AcceptCreateProjectCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 14.03.2023.
//

import Foundation
import UIKit
import Combine

final class AcceptCreateProjectCell: UITableViewCell {
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

private extension AcceptCreateProjectCell {
    func setupLayout() {
        addSubview(button)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.miniOffset),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.miniOffset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    func tapOnAcceptButton() {
        tapOnButtonSubject?.send()
    }
}
