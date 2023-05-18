//
//  QuizViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import UIKit
import Combine

final class QuizViewController: UIViewController {
    
    private let viewModel: QuizViewModelProtocol?
    private var interestsArray: [QuizCellModel] = .init()
    private var resultUserInterestsArray: [QuizModel] = .init()
    var rowWhichAreChecked = [NSIndexPath]()
    private var subscription = Set<AnyCancellable>()
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(QuizCheckBoxCell.self, forCellReuseIdentifier: "quiz")
        tableView.register(AcceptButtonViewCell.self, forCellReuseIdentifier: "accept")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewActions.lifeCycleSubject.send(.didLoad)
        setupLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    init(viewModel: QuizViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: TableView
extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interestsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < interestsArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath) as! QuizCheckBoxCell 
            cell.configureItem(model: interestsArray[indexPath.row])
            cell.backgroundColor = UIColor(named: "hseBackground")
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "accept") as! AcceptButtonViewCell
            cell.setSubject(subject: viewModel?.viewActions.showMainPageSubject)
            cell.backgroundColor = UIColor(named: "hseBackground")
            cell.configureCell(style: .entryOnProject)
            cell.setTitle(title: "Далее")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? AcceptButtonViewCell {
            viewModel?.viewActions.tapOnAcceptButton.send(resultUserInterestsArray)
        } else {
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! QuizCheckBoxCell
            cell.setCheckImg()
            cell.quizModel.isSelect = true
            resultUserInterestsArray.append(cell.quizModel.quiz)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! QuizCheckBoxCell
        if cell.quizModel.isSelect {
            cell.setUncheckImg()
            cell.quizModel.isSelect = false
            resultUserInterestsArray.removeAll(where: { $0.name == cell.quizModel.quiz.name })
        }
    }
}

private extension QuizViewController {
    func setupLayout() {
        view.backgroundColor = UIColor(named: "hseBackground")
        tableView.backgroundColor = UIColor(named: "hseBackground")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        title = "Интересы"
    }
    
    func bind() {
        viewModel?.data.quizArraySubject.sink(receiveValue: { [weak self] interests in
            self?.interestsArray = interests
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).store(in: &subscription)
    }
}
