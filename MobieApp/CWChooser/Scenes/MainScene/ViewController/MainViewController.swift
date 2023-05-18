//
//  MainViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 19.02.2023.
//

import Foundation
import Combine
import UIKit

final class MainViewController: UIViewController {
    enum Lists: String {
        case all = "Все"
        case recomended = "Рекомендованные"
        case entry = "Поданные"
    }
    
    private let viewModel: MainViewModelProtocol?
    private var projectsList: [Project] = .init()
    private var recomendedList: [Project] = .init()
    private var entryList: [Project] = .init()
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "hseBackground")
        tableView.separatorColor = .systemGray
        tableView.register(ProjectThemeViewCell.self, forCellReuseIdentifier: "project")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        return tableView
    }()
    
    private let segmentControl: UISegmentedControl = {
        let values = [Lists.all.rawValue, Lists.recomended.rawValue, Lists.entry.rawValue]
        let control = UISegmentedControl(items: values)
        control.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        control.overrideUserInterfaceStyle = .dark
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let activityIndicator: LoadingViewController = {
        let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext

        loadingVC.modalTransitionStyle = .crossDissolve
        return loadingVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavBar()
        bind()
        viewModel?.viewActions.lifecycle.send(.didLoad)
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.barTintColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addTapped))
        setupNavBar()
    }
    
    init(viewModel: MainViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSegmentedList() -> [Project] {
        let segmentInd = segmentControl.selectedSegmentIndex
        if segmentInd == 0 {
            return projectsList
        } else if segmentInd == 1 {
            return recomendedList
        } else {
            return entryList.filter { $0.status != "Заявка отменена" }
        }
    }
    
    @objc
    func reloadData(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            if sender.selectedSegmentIndex == 1 {
                self.viewModel?.viewActions.tapOnRecomendedProjectSegment.send()
            } else if sender.selectedSegmentIndex == 2 {
                self.viewModel?.viewActions.tapOnEntryProjectSegment.send()
            }
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getSegmentedList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = getSegmentedList()
        let cell = tableView.dequeueReusableCell(withIdentifier: "project") as! ProjectThemeViewCell
        let index = indexPath.row
        cell.configureCell(numberCell: index+1, model: list[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        let project = (tableView.cellForRow(at: indexPath) as! ProjectThemeViewCell).projectModel
        viewModel?.viewActions.tapOnProjectCellSubject.send((project, navigationController))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

private extension MainViewController {
    func bind() {
        viewModel?.data.projectsSendPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] projects in
                self?.projectsList = projects
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel?.data.recomendedProjectsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] projects in
                self?.recomendedList = projects
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel?.data.studentProjectsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] projects in
                self?.entryList = projects
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel?.viewActions.showActivityView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isShow in
                guard let self = self else { return }
                if isShow {
                    self.present(self.activityIndicator, animated: true)
                } else {
                    self.dismiss(animated: true)
                }
            }
            .store(in: &subscriptions)
    }
    
    func setupNavBar() {
        title = "Проекты"
    }
    
    @objc
    func addTapped() {
        guard let navController = navigationController else { return }
        viewModel?.viewActions.tapOnAddButtonSubject.send(navController)
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor(named: "hseBackground")
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            segmentControl.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
