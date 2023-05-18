//
//  DeadlineTableViewCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 16.04.2023.
//

import Foundation
import UIKit

final class DeadlineTableViewCell: UITableViewCell {
    
    private let grid = Grid()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Завести первый дедлайн"
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ура, это твой первый дедлайн"
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.7
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(tapOncheckButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isDone: Bool = false
    private var title: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, subtitle: String, color: UIColor, isDone: Bool) {
        self.title = title
        self.titleLabel.text = title
        self.titleLabel.textColor = color
        self.subtitleLabel.text = subtitle
        if isDone {
            let image = UIImage(systemName: "smallcircle.fill.circle")
            let attributedText = NSAttributedString(
                string: title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedText
            checkButton.setImage(image, for: .normal)
        }
    }
}

private extension DeadlineTableViewCell {
    enum Configuration {
        static let sideCheckButton: CGFloat = 30
    }
    
    func setupLayout() {
        contentView.backgroundColor = UIColor(named: "hseBackground")
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: grid.xlargeOffset),
//            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: grid.xlargeOffset),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: Configuration.sideCheckButton),
            checkButton.widthAnchor.constraint(equalToConstant: Configuration.sideCheckButton),
//            checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -grid.xlargeOffset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: grid.largeOffset),
            titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: grid.xxlargeOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -grid.xlargeOffset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: grid.microOffset),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -grid.largeOffset)
        ])
    }
    
    @objc
    func tapOncheckButton() {
        if isDone {
            checkButton.setImage(nil, for: .normal)
            titleLabel.textColor = .white
            titleLabel.attributedText = nil
            titleLabel.text = title
            isDone = false
        } else {
            let image = UIImage(systemName: "smallcircle.fill.circle")
            checkButton.setImage(image, for: .normal)
            let attributedText = NSAttributedString(
                string: self.title ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedText
            titleLabel.textColor = .systemRed
            isDone = true
        }
    }
}
