//
//  TitleTextfieldCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 08.03.2023.
//

import Foundation
import UIKit

final class TitleTextfieldCell: UITableViewCell {
    
    private let labelForTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldForTitle: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 12
        field.clipsToBounds = true
        field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        field.layer.borderWidth = 0.2
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.textColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String) {
        labelForTitle.text = title
        textFieldForTitle.attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
    }
    
    func getFieldInfo() -> String {
        textFieldForTitle.text ?? "приуэт"
    }
}

private extension TitleTextfieldCell {
    func setupLayout() {
        backgroundColor = UIColor(named: "hseBackground")
        contentView.addSubview(labelForTitle)
        contentView.addSubview(textFieldForTitle)
        
        NSLayoutConstraint.activate([
            labelForTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelForTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            textFieldForTitle.leadingAnchor.constraint(equalTo: labelForTitle.leadingAnchor),
            textFieldForTitle.topAnchor.constraint(equalTo: labelForTitle.bottomAnchor, constant: 8),
            textFieldForTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldForTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textFieldForTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
