//
//  ProjectDetailsViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 05.03.2023.
//

import Foundation
import UIKit
import Combine

final class ProjectDetailsViewController: UIViewController {
    
    private var viewModel: ProjectDetailsViewModelProtocol?
    private var projectData: ProjectData?
    private var applied: Bool?
    
    private let headerView: ProfileHeaderView = {
        let header = ProfileHeaderView()
        header.backgroundColor = UIColor(named: "hseBackground")
        header.layer.cornerRadius = 12
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .singleLine
        table.separatorColor = .systemGray
//        table.isScrollEnabled = false
        table.register(ProfileInfoViewCell.self, forCellReuseIdentifier: "infoCell")
        table.register(AcceptButtonViewCell.self, forCellReuseIdentifier: "acceptCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let activityIndicator: LoadingViewController = {
        let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext

        loadingVC.modalTransitionStyle = .crossDissolve
        return loadingVC
    }()
    
//    private let acceptButton: AcceptButtonView = {
//        let button = AcceptButtonView()
//        button.configureCell(title: "Запись на проект")
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewActions.lifeCycleSubject.send(.didLoad)
        bind()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Проект"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    init(viewModel: ProjectDetailsViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let techStackCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
           indexPath.row == 2 {
            techStackCell.configureItem(title: "Тэги", subTitle: projectData?.tags ?? "")
            techStackCell.selectionStyle = .none
            return techStackCell
        } else if let documentDeadlineCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 3 {
            documentDeadlineCell.configureItem(title: "Крайник срок заявки", subTitle: projectData?.projectInfo.submission_deadline ?? "")
            documentDeadlineCell.selectionStyle = .none
            return documentDeadlineCell
        }  else if let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                   indexPath.row == 1 {
            descriptionCell.configureItem(title: "Описание", subTitle: projectData?.projectInfo.description ?? "")
            descriptionCell.selectionStyle = .none
            return descriptionCell
        } else if let deadlineProjectCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 4 {
            deadlineProjectCell.configureItem(title: "Дедлайн работы", subTitle: projectData?.projectInfo.application_deadline ?? "")
            deadlineProjectCell.selectionStyle = .none
            return deadlineProjectCell
        } else if let typeOfProject = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 0 {
            typeOfProject.configureItem(title: "Тип работы", subTitle: projectData?.projectInfo.project_type ?? "")
            typeOfProject.selectionStyle = .none
            return typeOfProject
        } else if let membersList = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 5 {
            membersList.configureItem(title: "Участники", subTitle: "\(projectData?.projectInfo.number_of_students ?? 0) человек")
            membersList.selectionStyle = .none
            return membersList
        } else if let refOnProject = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 6 {
            refOnProject.configureItem(title: "Ссылка для официальной записи", subTitle: projectData?.projectInfo.application_form ?? "")
            refOnProject.selectionStyle = .none
            return refOnProject
        } else {
            let acceptButton = tableView.dequeueReusableCell(withIdentifier: "acceptCell", for: indexPath) as! AcceptButtonViewCell
            acceptButton.backgroundColor = UIColor(named: "hseBackground")
            acceptButton.selectionStyle = .none
            let style: AcceptButtonViewCell.Style = applied ?? false ? .cancelEntry : .entryOnProject
            acceptButton.configureCell(style: style)
            return acceptButton
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AcceptButtonViewCell,
           let project = projectData?.projectInfo {
            switch cell.style {
            case .entryOnProject:
                viewModel?.viewActions.tapOnAcceptButton.send(project.id)
                cell.changeStyle(style: .cancelEntry)
            case .cancelEntry:
                cell.changeStyle(style: .entryOnProject)
                viewModel?.viewActions.cancelTapButtonSubject.send(project.id)
            }
        }
    }
}

private extension ProjectDetailsViewController {
    
    func bind() {
        viewModel?.data.headerDataPublisher
            .sink { [weak self] headerData in
                DispatchQueue.main.async {
                    self?.headerView.setupHeader(type: headerData.type, title: headerData.title, subtitle: headerData.subtitle, image: headerData.image)
                }
            }
            .store(in: &subscriptions)
        
        viewModel?.data.projectDataSubject
            .sink { [weak self] projectData in
                self?.projectData = projectData
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel?.viewActions.appliedSubject
            .sink { [weak self] applied in
                DispatchQueue.main.async {
                    self?.applied = applied
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel?.viewActions.showActivityView
            .sink { [weak self] isShow in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.present(self.activityIndicator, animated: true)
                }
            }
            .store(in: &subscriptions)
        
        viewModel?.viewActions.dismissActivityView
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] dismiss in
                self?.dismiss(animated: true)
            })
            .store(in: &subscriptions)
        
//        viewModel?.viewActions.setEntryStylePublisher
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] style in
//                if let cell = self?.tableView.cellForRow(at: IndexPath(row: 8, section: 0)) as? AcceptButtonViewCell {
//                        cell.changeStyle(style: style)
////                        self?.tableView.reloadData()
//                }
//            }
//            .store(in: &subscriptions)
//
//        viewModel?.viewActions.setCancelStylePublisher
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] style in
//                if let cell = self?.tableView.cellForRow(at: IndexPath(row: 8, section: 0)) as? AcceptButtonViewCell {
//                    cell.changeStyle(style: style)
//                    self?.tableView.reloadData()
//                }
//            }
//            .store(in: &subscriptions)
    }
    
    func setupLayout() {
        view.backgroundColor = .black
        tableView.backgroundColor = UIColor(named: "hseBackground")
        
        view.addSubview(headerView)
        view.addSubview(tableView)
//        view.addSubview(acceptButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
//            acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
//            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
//            acceptButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
