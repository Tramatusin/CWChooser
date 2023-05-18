//
//  ProjectThemeViewCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import UIKit

final class ProjectThemeViewCell: UITableViewCell {
    
    private let grid = Grid()
    var projectModel = Project(id: 0, title: "", description: "", project_type: "", supervisor: "", number_of_students: 0, submission_deadline: "", application_deadline: "", application_form: "", status: "")
    
    private let viewForCellNumber: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "hseGray")
        label.layer.cornerRadius = 12
        label.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Исследование алгоритмов математического моделирования"
//        label.font = UIFont(name: "IowanOldStyle-Bold", size: 15)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teacherNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Витьковский Телевикер Телевикторович"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let projectSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Математика и алгоритмы"
        label.textColor = .systemGray
//        label.font = UIFont(name: "IowanOldStyle-Bold", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.text = "26 января 2023 - 01 марта 2023"
        label.textColor = .systemGray
//        label.font = UIFont(name: "IowanOldStyle-Bold", size: 12)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let clockImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "deadClock")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let teacherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteCap")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favourite"), for: .normal)
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
    
    func configureCell(numberCell: Int, model: Project) {
        self.projectModel = model
        self.titleNameLabel.text = model.title
        self.projectSectionLabel.text = model.project_type
        self.teacherNameLabel.text = model.supervisor
        self.viewForCellNumber.text = "\(numberCell)"
        self.deadlineLabel.text = "\(model.submission_deadline)/\(model.application_deadline)"
    }
}

private extension ProjectThemeViewCell {
    func setupLayout() {
        contentView.backgroundColor = UIColor(named: "hseBackground")
        addSubview(viewForCellNumber)
        addSubview(titleNameLabel)
        addSubview(teacherNameLabel)
        addSubview(clockImage)
        addSubview(deadlineLabel)
        addSubview(favouriteButton)
        addSubview(teacherImage)
        addSubview(projectSectionLabel)
        
        NSLayoutConstraint.activate([
            viewForCellNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewForCellNumber.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            viewForCellNumber.heightAnchor.constraint(equalToConstant: 22),
            viewForCellNumber.widthAnchor.constraint(equalToConstant: 35),
            
            projectSectionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            projectSectionLabel.leadingAnchor.constraint(equalTo: viewForCellNumber.trailingAnchor,
                                                         constant: 10),
            
            favouriteButton.topAnchor.constraint(equalTo: topAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            favouriteButton.heightAnchor.constraint(equalToConstant: 35),
            favouriteButton.widthAnchor.constraint(equalToConstant: 21),
            
            titleNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleNameLabel.topAnchor.constraint(equalTo: projectSectionLabel.bottomAnchor, constant: grid.xxxlargeOffset),
            titleNameLabel.trailingAnchor.constraint(equalTo: favouriteButton.trailingAnchor),
            
            teacherNameLabel.leadingAnchor.constraint(equalTo: teacherImage.trailingAnchor, constant: grid.largeOffset),
            teacherNameLabel.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 18),
            teacherNameLabel.heightAnchor.constraint(equalToConstant: 15),
            teacherNameLabel.trailingAnchor.constraint(equalTo: titleNameLabel.trailingAnchor),
            
            clockImage.leadingAnchor.constraint(equalTo: titleNameLabel.leadingAnchor),
            clockImage.topAnchor.constraint(equalTo: teacherNameLabel.bottomAnchor, constant: 20),
            clockImage.heightAnchor.constraint(equalToConstant: 20),
            clockImage.widthAnchor.constraint(equalToConstant: 20),
            
            teacherImage.leadingAnchor.constraint(equalTo: clockImage.leadingAnchor),
            teacherImage.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: grid.xxxlargeOffset),
            teacherImage.heightAnchor.constraint(equalToConstant: 20),
            teacherImage.widthAnchor.constraint(equalToConstant: 20),
            
            deadlineLabel.leadingAnchor.constraint(equalTo: clockImage.trailingAnchor, constant: grid.largeOffset),
            deadlineLabel.topAnchor.constraint(equalTo: teacherNameLabel.bottomAnchor, constant: 22),
            deadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
