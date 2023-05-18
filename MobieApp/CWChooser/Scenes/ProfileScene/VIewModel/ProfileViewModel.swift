//
//  ProfileViewModel.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 25.02.2023.
//

import Foundation
import Combine

typealias ProfileViewModelProtocol = ProfileViewModelInputOutput & ProfileViewModelViewActionsData

final class ProfileViewModel: ProfileViewModelProtocol {
    var input: ProfileViewModelInput
    
    var output: ProfileViewModelOutput
    
    var viewActions: ProfileViewModelViewActions
    
    var data: ProfileViewModelData
    
    private let networkService: NetworkServiceProtocol
    private let user: UserModel
    private var subscription = Set<AnyCancellable>()
    private let userInfoDataSubject = PassthroughSubject<UserInfoResponse, Never>()
    private let userInterestsSubject = PassthroughSubject<String, Never>()
    
    init(networkService: NetworkServiceProtocol, user: UserModel) {
        self.input = .init()
        self.output = .init()
        self.viewActions = .init()
        self.data = .init(userInfoDataSubject: userInfoDataSubject.eraseToAnyPublisher(), userInterestsSubject: userInterestsSubject.eraseToAnyPublisher())
        self.networkService = networkService
        self.user = user
        bind()
    }
}

private extension ProfileViewModel {
    func bind() {
        viewActions.lifecycle
            .sink { [weak self] lifecycle in
                switch lifecycle {
                case .didLoad:
                    self?.getUserInfo()
                default: return
                }
            }
            .store(in: &subscription)
    }
    
    func getUserInfo() {
        networkService.getStudentInfo(studentId: user.id) { [weak self] result in
            switch result {
            case .success(let users):
                guard let user = users.first else { return }
                self?.userInfoDataSubject.send(user)
            case .failure(let error):
                print(error)
            }
        }
        
        networkService.getStudentInterests(studentId: user.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let interests):
                let interests = self.getTagsString(tags: interests)
                self.userInterestsSubject.send(interests)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTagsString(tags: [Interests]) -> String {
        var result = ""
        for item in tags {
            if tags.last?.name == item.name {
                result += item.name
            } else {
                result += item.name + ", "
            }
        }
        return result
    }
}
