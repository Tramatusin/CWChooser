//
//  CreateUserViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import UIKit

final class CreateUserViewController: UIViewController {
    
    private let viewModel: CreateUserViewModelProtocol
    private let user: UserModel
    
    private lazy var table: UITableView = {
        let mainView = UITableView()
        mainView.register(TitleTextfieldCell.self, forCellReuseIdentifier: "titleCell")
        mainView.register(AcceptCreateUserCell.self, forCellReuseIdentifier: "acceptCell")
        mainView.delegate = self
        mainView.dataSource = self
        mainView.backgroundColor = UIColor(named: "hseBackground")
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "О себе"
    }
    
    init(viewModel: CreateUserViewModelProtocol, user: UserModel) {
        self.viewModel = viewModel
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
           indexPath.row == 0 {
            titleCell.configureCell(title: "Ф.И.О")
            titleCell.selectionStyle = .none
            return titleCell
        } else if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 1 {
            descriptionCell.configureCell(title: "Факультет")
            descriptionCell.selectionStyle = .none
            return descriptionCell
        } else if let superVisior = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 2 {
            superVisior.configureCell(title: "Группа")
            superVisior.selectionStyle = .none
            return superVisior
        } else if let numberOfStudents = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 3 {
            numberOfStudents.configureCell(title: "Курс")
            numberOfStudents.selectionStyle = .none
            return numberOfStudents
        } else if let numberOfStudents = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 4 {
            numberOfStudents.configureCell(title: "Номер телефона")
            numberOfStudents.selectionStyle = .none
            return numberOfStudents
        }else {
            let acceptButton = tableView.dequeueReusableCell(withIdentifier: "acceptCell", for: indexPath) as! AcceptCreateUserCell
            acceptButton.configureCell(title: "Создать")
            acceptButton.backgroundColor = UIColor(named: "hseBackground")
            acceptButton.selectionStyle = .none
            return acceptButton
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fougou")
        if let _ = tableView.cellForRow(at: indexPath) as? AcceptCreateUserCell {
            guard
                let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleTextfieldCell,
                let facultyCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TitleTextfieldCell,
                let groupCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TitleTextfieldCell,
                let courseCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TitleTextfieldCell,
                let numberCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? TitleTextfieldCell
            else { return }
            let userInfo = UserInfoModel(
                student_id: user.id,
                name: nameCell.getFieldInfo(),
                group: facultyCell.getFieldInfo(),
                faculty: groupCell.getFieldInfo(),
                year: Int(courseCell.getFieldInfo()) ?? 0,
                phone_number: numberCell.getFieldInfo()
            )
            viewModel.viewActions.tapOnAcceptCell.send(userInfo)
        }
    }
}

private extension CreateUserViewController {
    func setupLayout() {
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
