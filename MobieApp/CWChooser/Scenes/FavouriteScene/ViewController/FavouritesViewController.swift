//
//  FavouritesViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 06.05.2023.
//

import Foundation
import UIKit

final class FavouritesViewController: UIViewController {
    private let viewModel: FavouritesViewModelViewActionsData
    private let favourites: [Project] = [
        Project(id: 1, title: "Loopa", description: "feree", project_type: "Rjfj", supervisor: "defnk", number_of_students: 2, submission_deadline: "", application_deadline: "", application_form: "", status: ""),
        Project(id: 2, title: "hoopa", description: "preee", project_type: "kodek", supervisor: "fsfdfs", number_of_students: 5, submission_deadline: "feesesf", application_deadline: "fees", application_form: "fd", status: "feses")
    ]
    
    init(viewModel: FavouritesViewModelViewActionsData) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Избранное"
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProjectThemeViewCell.self, forCellReuseIdentifier: "favouriteCell")
        return tableView
    }()
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! ProjectThemeViewCell
        cell.configureCell(numberCell: indexPath.row + 1, model: favourites[indexPath.row])
        return cell
    }
}

private extension FavouritesViewController {
    func bind() {
        
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "hseBackground")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
