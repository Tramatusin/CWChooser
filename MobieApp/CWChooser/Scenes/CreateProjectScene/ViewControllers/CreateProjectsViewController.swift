//
//  CreateProjectsViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 08.03.2023.
//

import Foundation
import UIKit

final class CreateProjectsViewController: UIViewController {
    
    private let viewModel: CreateProjectsViewModelProtocol
    
    private lazy var table: UITableView = {
        let mainView = UITableView()
        mainView.register(TitleTextfieldCell.self, forCellReuseIdentifier: "titleCell")
        mainView.register(SegmentDataCell.self, forCellReuseIdentifier: "segmentCell")
        mainView.register(AcceptCreateProjectCell.self, forCellReuseIdentifier: "acceptCell")
        mainView.delegate = self
        mainView.dataSource = self
        mainView.backgroundColor = UIColor(named: "hseBackground")
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    init(viewModel: CreateProjectsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Создание проекта"
        tabBarController?.tabBar.isHidden = true
    }
}

extension CreateProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
           indexPath.row == 0 {
            titleCell.configureCell(title: "Название")
            titleCell.selectionStyle = .none
            return titleCell
        } else if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 1 {
            descriptionCell.configureCell(title: "Описание")
            descriptionCell.selectionStyle = .none
            return descriptionCell
        } else if let superVisior = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 2 {
            superVisior.configureCell(title: "Заказчик")
            superVisior.selectionStyle = .none
            return superVisior
        } else if let numberOfStudents = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 3 {
            numberOfStudents.configureCell(title: "Количество студентов")
            numberOfStudents.selectionStyle = .none
            return numberOfStudents
        } else if let applicationForm = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 4 {
            applicationForm.configureCell(title: "Форма для записи")
            applicationForm.selectionStyle = .none
            return applicationForm
        } else if let statusCell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTextfieldCell,
                  indexPath.row == 5 {
            statusCell.configureCell(title: "Статус работы")
            statusCell.selectionStyle = .none
            return statusCell
        } else if let segmentCell = tableView.dequeueReusableCell(withIdentifier: "segmentCell", for: indexPath) as? SegmentDataCell,
                  indexPath.row == 6 {
            segmentCell.selectionStyle = .none
            return segmentCell
        } else {
            let acceptButton = tableView.dequeueReusableCell(withIdentifier: "acceptCell", for: indexPath) as! AcceptCreateProjectCell
            acceptButton.configureCell(title: "Создать")
            acceptButton.backgroundColor = UIColor(named: "hseBackground")
            acceptButton.selectionStyle = .none
            return acceptButton
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fougou")
        if let _ = tableView.cellForRow(at: indexPath) as? AcceptCreateProjectCell {
            guard
                let titleCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TitleTextfieldCell,
                let descriptionCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TitleTextfieldCell,
                let superVisiorCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? TitleTextfieldCell,
                let numberOfStudentsCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? TitleTextfieldCell,
                let segmentDataCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? SegmentDataCell,
                let applicationCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? TitleTextfieldCell,
                let statusCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? TitleTextfieldCell
            else { return }
            let descriptionModel = Project.DescriptionModel(
                title: titleCell.getFieldInfo(),
                description: descriptionCell.getFieldInfo(),
                superVisior: superVisiorCell.getFieldInfo(),
                numberOfStudents: numberOfStudentsCell.getFieldInfo()
            )
            let segmentModel = segmentDataCell.getSegmentInfo()
            let project = ProjectRequest(
                title: descriptionModel.title,
                description: descriptionModel.description,
                project_type: segmentModel.projectType,
                supervisor: descriptionModel.superVisior,
                number_of_students: Int(descriptionModel.numberOfStudents) ?? 0,
                submission_deadline: getDateStringWithoutTime(string: segmentModel.submissionDate.description),
                application_deadline: getDateStringWithoutTime(string: segmentModel.applicationDate.description),
                application_form: applicationCell.getFieldInfo(),
                status: statusCell.getFieldInfo()
            )
            viewModel.data.sendProjectModelSubject.send(project)
        }
    }
}

private extension CreateProjectsViewController {
    func setupLayout() {
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getDateStringWithoutTime(string: String) -> String {
        var result = ""
        for char in string {
            if char == " " {
                break
            } else {
                result.append(char)
            }
        }
        return result
    }
}
