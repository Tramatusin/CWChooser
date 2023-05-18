//
//  DeadlineHeaderView.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 18.04.2023.
//

import Foundation
import UIKit

final class DeadlineHeaderView: UIView {
    
    private let grid = Grid()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Не забывайте контролировать время"
        label.textColor = UIColor(named: "HseBlue")
        label.font = .boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let todayDateLabel: UILabel = {
        let label = UILabel()
        var time = NSDate()
        var formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        var formatteddate = formatter.string(from: time as Date)
        label.text = "Сегодня: \(formatteddate)"
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DeadlineHeaderView {
    func setupLayout() {
        backgroundColor = UIColor(named: "hseBackground")
        addSubview(hintLabel)
        addSubview(todayDateLabel)
        
        NSLayoutConstraint.activate([
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xlargeOffset),
            hintLabel.topAnchor.constraint(equalTo: topAnchor, constant: grid.miniOffset),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            
            todayDateLabel.topAnchor.constraint(equalTo: hintLabel.bottomAnchor),
            todayDateLabel.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
            todayDateLabel.trailingAnchor.constraint(equalTo: hintLabel.trailingAnchor),
            todayDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -grid.xlargeOffset)
        ])
    }
}
