//
//  QuizViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 12.02.2023.
//

import Foundation
import Combine
import UIKit

typealias QuizViewModelProtocol = QuizViewModelInputOutput & QuizViewModelViewActionData

final class QuizViewModel: QuizViewModelProtocol {
    var input: QuizViewModelInput
    
    var output: QuizViewModelOutput
    
    var data: QuizViewModelData
    
    var viewActions: QuizViewModelViewActions
    
    private var subscription = Set<AnyCancellable>()
    private let navController: UINavigationController
    private let networkService: NetworkServiceProtocol
    private let user: UserModel
    
//    private let interests = ["Математика", "Мобильная разработка", "ML", "Backend", "Большие данные", "Аналитика", "Дизайн", "Frontend"]
    
    init(navController: UINavigationController, networkService: NetworkServiceProtocol, user: UserModel) {
        self.input = .init()
        self.output = .init()
        self.data = .init()
        self.viewActions = .init()
        self.navController = navController
        self.networkService = networkService
        self.user = user
        bind()
    }
    
    func bind() {
        viewActions.lifeCycleSubject.sink { [weak self] lifecycle in
            guard let self = self else { return }
            switch lifecycle {
            case .didLoad:
                self.getDetails()
            default: break
            }
        }.store(in: &subscription)
        
        viewActions.tapOnAcceptButton.sink { [weak self] models in
            guard let self = self else { return }
            for model in models {
                let quizRespModel = QuizResponseModel(student_id: self.user.id, interest_id: model.id)
                self.networkService.studentInterestsSend(with: quizRespModel) { result in
                    switch result {
                    case .success(let model):
                        print(model)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            self.openMainPages()
        }.store(in: &subscription)
    }
    
    func getDetails() {
        networkService.getAllTags { [weak self] result in
            switch result {
            case .success(let quizes):
                let cellQuizes = quizes.map({ QuizCellModel(quiz: $0, isSelect: false) })
                self?.data.quizArraySubject.send(cellQuizes)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sendQuizModelsFromStudent(models: [QuizModel]) {
        
    }
    
    func openMainPages() {
        let tabBar = UITabBarController()
        let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        let mainVC = MainSceneAssembly.build(navigationController: self.navController, networkService: networkService, user: user)
        let mainVCNC = UINavigationController(rootViewController: mainVC)
        
        let profileVC = ProfileSceneAssembly.build(networkService: networkService, user: user)
        let profileVCNC = UINavigationController(rootViewController: profileVC)
        
        let deadlineVC = DeadlineSceneAssembly.buildMain()
        let deadlineVCNC = UINavigationController(rootViewController: deadlineVC)
        
        let favouriteVC = FavouriteSceneAssembly.build()
        let favouriteVCNC = UINavigationController(rootViewController: favouriteVC)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.backgroundColor = UIColor(named: "hseNavBar")
        
        mainVCNC.navigationBar.standardAppearance = appearance;
        mainVCNC.navigationBar.scrollEdgeAppearance = mainVCNC.navigationBar.standardAppearance
        
        profileVCNC.navigationBar.standardAppearance = appearance;
        profileVCNC.navigationBar.scrollEdgeAppearance = profileVCNC.navigationBar.standardAppearance
        
        deadlineVCNC.navigationBar.standardAppearance = appearance;
        deadlineVCNC.navigationBar.scrollEdgeAppearance = deadlineVCNC.navigationBar.standardAppearance
        
        favouriteVCNC.navigationBar.standardAppearance = appearance;
        favouriteVCNC.navigationBar.scrollEdgeAppearance = favouriteVCNC.navigationBar.standardAppearance
        
        tabBar.viewControllers = [mainVCNC, favouriteVCNC, deadlineVCNC, profileVCNC]
        tabBar.tabBar.items?[0].image = UIImage(named: "projects")!
        tabBar.tabBar.items?[3].image = UIImage(named: "profile")!
        tabBar.tabBar.items?[3].title = "Профиль"
        tabBar.tabBar.items?[1].image = UIImage(named: "favorite")!
        tabBar.tabBar.items?[1].title = "Избранные"
        tabBar.tabBar.items?[2].image = UIImage(named: "fire")!
        tabBar.tabBar.items?[2].title = "Дедлайны"
        
        appDelegate?.setRootViewController(tabBar)
    }
}
