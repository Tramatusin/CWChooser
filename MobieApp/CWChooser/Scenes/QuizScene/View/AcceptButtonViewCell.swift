//
//  AcceptButtonViewCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import UIKit
import Combine

final class AcceptButtonViewCell: UITableViewCell {
    enum Style: String {
        case entryOnProject = "Запись на проект"
        case cancelEntry = "Отмена записи"
    }
    
    typealias LOC = Localization.QuizViewController
    private let grid = Grid()
    private var tapOnButtonSubject: PassthroughSubject<Void, Never>?
    var style: Style = .entryOnProject
    
    private let button: UIButton = {
        let button = UIButton()
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
    
    func configureCell(style: Style) {
        switch style{
        case .entryOnProject:
            self.style = .entryOnProject
            button.backgroundColor = UIColor(named: "HseBlue")
        case .cancelEntry:
            self.style = .cancelEntry
            button.backgroundColor = UIColor.systemRed
        }
        button.setTitle(style.rawValue, for: .normal)
    }
    
    func changeStyle(style: Style) {
        switch style{
        case .entryOnProject:
            self.style = .entryOnProject
            button.backgroundColor = UIColor(named: "HseBlue")
            setTitle(title: style.rawValue)
        case .cancelEntry:
            self.style = .cancelEntry
            button.backgroundColor = UIColor.systemRed
            setTitle(title: style.rawValue)
        }
    }
    
    func setTitle(title: String) {
        button.setTitle(title, for: .normal)
    }
}

private extension AcceptButtonViewCell {
    func setupLayout() {
        addSubview(button)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.miniOffset),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.miniOffset),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    func tapOnAcceptButton() {
        tapOnButtonSubject?.send()
    }
}
