//
//  AuthorizationViewController.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import UIKit
import Combine

class AuthorizationViewController: UIViewController {
    
    private var viewModel: AuthViewModelProtocol?
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var mainView: AuthMainView = {
        let mainView = AuthMainView(frame: CGRect(), buttonSubject: viewModel?.output.buttonTabSubject)
       return mainView
    }()

    override func loadView() {
        view = mainView
    }
    
    init(viewModel: AuthViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localization.AuthViewController.signIn
    }
}

private extension AuthorizationViewController {
    func bind() {
        viewModel?.viewActions.showQuizPublisher.sink(receiveValue: { [weak self] vc in
            print("показать квиз")
            self?.navigationController?.pushViewController(vc, animated: false)
        }).store(in: &subscriptions)
    }
}
