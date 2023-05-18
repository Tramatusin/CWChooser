//
//  ProfileViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation
import UIKit
import Combine

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel?
    private var userInfo: UserInfoResponse?
    private var subscriptions = Set<AnyCancellable>()
    private var interestsString = "Frontend, Swift, Мобильная разработка, Fullstack-разработка"
    
    //MARK: Test
    private let user = UserInfoResponse(id: 14, email: "arteezycat@gmail.com", faculty: "ФКН", group: "БПИ196", name: "", phone_number: "+79283390387", year: 4)
    
    private let headerView: ProfileHeaderView = {
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.cornerRadius = 12
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ProfileInfoViewCell.self, forCellReuseIdentifier: "infoCell")
        table.separatorColor = .systemGray
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupLayout()
        viewModel?.viewActions.lifecycle.send(.didLoad)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tabBarController?.tabBar.
        setupNavBar()
    }
    
    init(viewModel: ProfileViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let facultyCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 1 {
            facultyCell.configureItem(title: "Факультет", subTitle: user.group ?? "")
            return facultyCell
        } else if let emailCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 2 {
            emailCell.configureItem(title: "Email-адрес", subTitle: user.email ?? "")
            return emailCell
        } else if let interestCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? ProfileInfoViewCell,
                  indexPath.row == 0 {
            interestCell.configureItem(title: "Интересы", subTitle: interestsString)
            return interestCell
        } else {
            let telephoneNumberCell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! ProfileInfoViewCell
            telephoneNumberCell.configureItem(title: "Номер телефона", subTitle: user.phone_number ?? "")
            return telephoneNumberCell
        }
    }
}

private extension ProfileViewController {
    func bind() {
        viewModel?.data.userInfoDataSubject
            .sink { [weak self] user in
                self?.userInfo = user
                DispatchQueue.main.async {
                    self?.headerView.setupHeader(
                        type: "СТУДЕНТ",
                        title: user.name,
                        subtitle: "Бакалавриат \(user.faculty)",
                        image: nil
                    )
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel?.data.userInterestsSubject
            .sink { [weak self] interests in
                self?.interestsString = interests
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavBar() {
        title = "Профиль"
    }
    
    func setupLayout() {
        view.backgroundColor = .black
        tableView.backgroundColor = UIColor(named: "hseBackground")
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
