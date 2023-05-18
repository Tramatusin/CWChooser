//
//  SegmentDataCell.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.03.2023.
//

import Foundation
import UIKit

final class SegmentDataCell: UITableViewCell {
    private let segmentTypeControl: UISegmentedControl = {
        let items = ["Исследовательская", "Практическая"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.overrideUserInterfaceStyle = .dark
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    private let labelDateSub: UILabel = {
        let label = UILabel()
        label.text = "Дедлайн подачи заявки"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelDateApp: UILabel = {
        let label = UILabel()
        label.text = "Дедлайн работы"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateSubmission: UIDatePicker = {
        let date = UIDatePicker()
        date.overrideUserInterfaceStyle = .dark
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    private let dateApplication: UIDatePicker = {
        let date = UIDatePicker()
        date.overrideUserInterfaceStyle = .dark
        date.datePickerMode = .date
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSegmentInfo() -> Project.SegmentDateModel {
        let type: Project.SegmentDateModel.TypeProject = segmentTypeControl.selectedSegmentIndex == 0 ? .research : .praktic
        let dateSub = dateSubmission.date
        let dateApp = dateApplication.date
        return Project.SegmentDateModel(projectType: type.rawValue, submissionDate: dateSub, applicationDate: dateApp)
    }
}

private extension SegmentDataCell {
    func setupLayout() {
        backgroundColor = UIColor(named: "hseBackground")
        contentView.addSubview(segmentTypeControl)
        contentView.addSubview(labelDateSub)
        contentView.addSubview(dateSubmission)
        contentView.addSubview(labelDateApp)
        contentView.addSubview(dateApplication)
        
        NSLayoutConstraint.activate([
            segmentTypeControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            segmentTypeControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            labelDateSub.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelDateSub.topAnchor.constraint(equalTo: segmentTypeControl.bottomAnchor, constant: 16),
            
            dateSubmission.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateSubmission.topAnchor.constraint(equalTo: labelDateSub.bottomAnchor, constant: 16),
            
            labelDateApp.leadingAnchor.constraint(equalTo: labelDateSub.leadingAnchor),
            labelDateApp.topAnchor.constraint(equalTo: dateSubmission.bottomAnchor, constant: 16),
            
            dateApplication.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateApplication.topAnchor.constraint(equalTo: labelDateApp.bottomAnchor, constant: 16),
            dateApplication.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}
 
