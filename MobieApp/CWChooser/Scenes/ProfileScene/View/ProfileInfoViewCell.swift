//
//  ProfileInfoViewCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit

/// Ячейка для отображения информации о юзере
final class ProfileInfoViewCell: UITableViewCell {
    private let grid = Grid()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
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
    
    func configureItem(title: String, subTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
}

private extension ProfileInfoViewCell {
    
    func setupLayout() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        backgroundColor = UIColor(named: "hseBackground")
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xxxlargeOffset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: grid.largeOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xxxlargeOffset),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: grid.xlargeOffset),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -grid.largeOffset)
        ])
    }
    
}
