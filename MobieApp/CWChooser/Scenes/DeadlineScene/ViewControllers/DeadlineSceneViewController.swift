//
//  DeadlineSceneViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.04.2023.
//

import Foundation
import UIKit

final class DeadlineSceneViewController: UIViewController {
    private let viewModel: DeadlineSceneViewModelViewActionsData
    private let deadlines = [DeadlineModel(name: "Сделать документы к ПДП", description: "15.04.2023", isDone: true),
                             DeadlineModel(name: "Предзащита", description: "28.04.2023", isDone: false),
                             DeadlineModel(name: "Защита диплома", description: "02.06.2023", isDone: false)]
    
    init(viewModel: DeadlineSceneViewModelViewActionsData) {
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
        title = "Дедлайны"
        setupNavBar()
    }
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(DeadlineTableViewCell.self, forCellReuseIdentifier: "deadlineCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.layer.cornerRadius = 12
        tableview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let headerView: DeadlineHeaderView = {
        let header = DeadlineHeaderView()
        header.layer.cornerRadius = 12
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
}

extension DeadlineSceneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deadlineCell", for: indexPath) as! DeadlineTableViewCell
        let deadline = deadlines[indexPath.row]
        if indexPath.row == deadlines.count - 1 {
            cell.configureCell(title: deadline.name, subtitle: deadline.description, color: .white, isDone: false)
        } else {
            cell.configureCell(title: deadline.name, subtitle: deadline.description, color: .systemRed, isDone: true)
        }
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 12
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        return cell
    }
}

private extension DeadlineSceneViewController {
    func bind() {
        
    }
    
    func setupLayout() {
        view.backgroundColor = .black
        tableView.backgroundColor = UIColor(named: "hseBackground")
        view.addSubview(tableView)
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTapped))
    }
    
    @objc
    func addTapped() {
        let vc = AddDeadlineViewController(viewModel: AddDeadlineViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
}
