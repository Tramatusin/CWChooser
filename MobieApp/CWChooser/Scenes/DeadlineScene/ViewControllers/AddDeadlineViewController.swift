//
//  AddDeadlineViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 06.05.2023.
//

import Foundation
import UIKit

final class AddDeadlineViewController: UIViewController {
    private let viewModel: AddDeadlineViewModelViewActionsData
    
    init(viewModel: AddDeadlineViewModelViewActionsData) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Создать дедлайн"
    }
    
    private let deadlineNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название:"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadlineDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadlineDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата дедлайна:"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadlineNameTextField: UITextField = {
        let deadlineNameTF = UITextField()
        deadlineNameTF.layer.cornerRadius = 12
        deadlineNameTF.clipsToBounds = true
        deadlineNameTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        deadlineNameTF.layer.borderWidth = 0.2
        deadlineNameTF.layer.borderColor = UIColor.systemGray.cgColor
        deadlineNameTF.textColor = .white
        deadlineNameTF.placeholder = "Название"
        deadlineNameTF.translatesAutoresizingMaskIntoConstraints = false
        return deadlineNameTF
    }()
    
    private let deadlineDescriptionTextField: UITextField = {
        let deadlineDescriptionTF = UITextField()
        deadlineDescriptionTF.layer.cornerRadius = 12
        deadlineDescriptionTF.clipsToBounds = true
        deadlineDescriptionTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        deadlineDescriptionTF.layer.borderWidth = 0.2
        deadlineDescriptionTF.layer.borderColor = UIColor.systemGray.cgColor
        deadlineDescriptionTF.textColor = .white
        deadlineDescriptionTF.placeholder = "Описание"
        deadlineDescriptionTF.translatesAutoresizingMaskIntoConstraints = false
        return deadlineDescriptionTF
    }()
    
    private let deadlineData: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let acceptCreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.backgroundColor = UIColor(named: "HseBlue")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

private extension AddDeadlineViewController {
    func setupLayout() {
        view.addSubview(deadlineNameLabel)
        view.addSubview(deadlineNameTextField)
        view.addSubview(deadlineDescriptionLabel)
        view.addSubview(deadlineDescriptionTextField)
        view.addSubview(deadlineDateLabel)
        view.addSubview(deadlineData)
        view.addSubview(acceptCreateButton)
        
        NSLayoutConstraint.activate([
            deadlineNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            deadlineNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            deadlineNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            deadlineNameTextField.topAnchor.constraint(equalTo: deadlineNameLabel.bottomAnchor, constant: 12),
            deadlineNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            deadlineNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            deadlineNameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            deadlineDescriptionLabel.topAnchor.constraint(equalTo: deadlineNameTextField.bottomAnchor, constant: 12),
            deadlineDescriptionLabel.leadingAnchor.constraint(equalTo: deadlineNameLabel.leadingAnchor),
            deadlineDescriptionLabel.trailingAnchor.constraint(equalTo: deadlineNameLabel.trailingAnchor),
            
            deadlineDescriptionTextField.topAnchor.constraint(equalTo: deadlineDescriptionLabel.bottomAnchor, constant: 12),
            deadlineDescriptionTextField.leadingAnchor.constraint(equalTo: deadlineNameTextField.leadingAnchor),
            deadlineDescriptionTextField.trailingAnchor.constraint(equalTo: deadlineNameTextField.trailingAnchor),
            deadlineDescriptionTextField.heightAnchor.constraint(equalToConstant: 35),
            
            deadlineDateLabel.topAnchor.constraint(equalTo: deadlineDescriptionTextField.bottomAnchor, constant: 12),
            deadlineDateLabel.leadingAnchor.constraint(equalTo: deadlineNameLabel.leadingAnchor),
            deadlineDateLabel.trailingAnchor.constraint(equalTo: deadlineNameLabel.trailingAnchor),
            
            deadlineData.topAnchor.constraint(equalTo: deadlineDateLabel.bottomAnchor, constant: 12),
            deadlineData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            acceptCreateButton.topAnchor.constraint(equalTo: deadlineData.bottomAnchor, constant: 32),
            acceptCreateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            acceptCreateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            acceptCreateButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc
    func tapOnButton() {
        print("yoyoyoyo")
    }
}


