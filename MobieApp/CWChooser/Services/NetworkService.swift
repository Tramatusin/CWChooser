//
//  NetworkService.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 15.03.2023.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    /// Авторизация юзера
    func authorizeUser(model: AuthRequestModel)
    
    /// Создание информации о студенте
    func studentInfoCreate(userInfo: UserInfoModel, handler: @escaping (Result<Data, Error>) -> Void)
    
    /// Получение всех возможных тегов
    func getAllTags(handler: @escaping (Result<[QuizModel], Error>) -> Void)
    
    /// Получение полного перечня проектов
    func getAllProjects(handler: @escaping (Result<[Project], Error>) -> Void)
    
    /// получить все тэги проекта
    func getAllRequirements(projectId: Int, handler: @escaping (Result<[Tag], Error>) -> Void)
    
    /// Получить информацию о студенте
    func getStudentInfo(studentId: Int, handler: @escaping (Result<[UserInfoResponse], Error>) -> Void)
    
    /// Получить интересы студента
    func getStudentInterests(studentId: Int, handler: @escaping (Result<[Interests], Error>) -> Void)
    
    /// Добавить выбранные интересы студенту
    func studentInterestsSend(with requestModel: QuizResponseModel, handler: @escaping (Result<Data, Error>) -> Void)
    
    /// Запись студента на проект
    func entryOnProject(with model: EntryOnProjectModel, handler: @escaping (Result<Data, Error>) -> Void)
    
    /// Отмена записи на проект
    func cancelEntryOnProject(with application: ApplicationRequest, id: Int, status: String, handler: @escaping (Result<Data, Error>) -> Void)

    /// Создание проекта
    func createProject(with project: ProjectRequest, handler: @escaping (Result<Data, Error>) -> Void)
    
    /// Проекты студента
    func studentProjects(with studentId: Int, handler: @escaping (Result<[Project], Error>) -> Void)
    
    /// Рекомендованные проекты
    func recomendedProjects(with studentId: Int, handler: @escaping (Result<[Project], Error>) -> Void)
    
    /// Все аппликейшены
    func getAllApplications(handler: @escaping (Result<[Application], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
        
    var mainPath: String {
        "http://84.201.135.211:8002/"
    }
    
    private enum Paths: String {
//        case
        case projects = "projects/"
        case infoCreate = "student_info_create/"
        case interests = "requirements/"
        case studentsTags = "interests_by_student/"
        case requirementsByProject = "requirements_by_project/"
        case studentInfo = "information_by_student/"
        case studentInterestSent = "student_interest_create/"
        case entryOnProject = "application_create/"
        case cancelEntry = "applications/"
        case studentProjects = "applications_by_student/"
        case studentRecomendation = "student_suggestions/"
        case projectCreate = "project_create/"
    }
    
    func authorizeUser(model: AuthRequestModel) {
//        guard let url = URL(string: mainPath + Paths.infoCreate.rawValue) else { return }
    }
    
    func studentInfoCreate(userInfo: UserInfoModel, handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.infoCreate.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let data = try? JSONEncoder().encode(userInfo) else { return }
        
        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
//                guard let userInfo = try? JSONDecoder().decode(UserInfoResponse.self, from: data) else { return }
                handler(.success(data))
            }
        }.resume()
    }
    
    func getAllTags(handler: @escaping (Result<[QuizModel], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.interests.rawValue) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                guard let quizArray = try? JSONDecoder().decode([QuizModel].self, from: data) else { return }
                handler(.success(quizArray))
            }
        }.resume()
    }
    
    func getAllProjects(handler: @escaping (Result<[Project], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.projects.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                guard let projects = try? JSONDecoder().decode([Project].self, from: data) else { return }
                handler(.success(projects))
            }
        }.resume()
    }
    
    func getAllRequirements(projectId: Int, handler: @escaping (Result<[Tag], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.requirementsByProject.rawValue + "\(projectId)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                guard let tags = try? JSONDecoder().decode([Tag].self, from: data) else { return }
                handler(.success(tags))
            }
        }.resume()
    }
    
    func getStudentInfo(studentId: Int, handler: @escaping (Result<[UserInfoResponse], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.studentInfo.rawValue + "\(studentId)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                guard let infoStudent = try? JSONDecoder().decode([UserInfoResponse].self, from: data) else { return }
                handler(.success(infoStudent))
            }
        }.resume()
    }
    
    func getStudentInterests(studentId: Int, handler: @escaping (Result<[Interests], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.studentsTags.rawValue + "\(studentId)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                guard let interests = try? JSONDecoder().decode([Interests].self, from: data) else { return }
                handler(.success(interests))
            }
        }.resume()
    }
    
    func studentInterestsSend(with requestModel: QuizResponseModel, handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.studentInterestSent.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let data = try? JSONEncoder().encode(requestModel) else { return }

        request.httpMethod = "POST"
        request.httpBody = data

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                handler(.success(data))
            }
        }.resume()
    }
    
    func entryOnProject(with model: EntryOnProjectModel, handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.entryOnProject.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let data = try? JSONEncoder().encode(model) else { return }

        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                handler(.success(data))
            }
        }.resume()
    }
    
    func cancelEntryOnProject(with application: ApplicationRequest, id: Int, status: String = "заявка отменена", handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.cancelEntry.rawValue + "\(id)/") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let data = try? JSONEncoder().encode(application) else { return }

        request.httpMethod = "PUT"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                handler(.success(data))
            }
        }.resume()
    }
    
    func getAllApplications(handler: @escaping (Result<[Application], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.cancelEntry.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let applications = try? JSONDecoder().decode([Application].self, from: data) else { return }
                handler(.success(applications))
            }
            if let error = error {
                handler(.failure(error))
            }
        }.resume()
    }
    
    func createProject(with project: ProjectRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.projectCreate.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let data = try? JSONEncoder().encode(project) else { return }

        request.httpMethod = "POST"
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
            }
            if let data = data {
                handler(.success(data))
            }
        }.resume()
    }
    
    func studentProjects(with studentId: Int, handler: @escaping (Result<[Project], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.studentProjects.rawValue + "\(studentId)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let projects = try? JSONDecoder().decode([Project].self, from: data) else { return }
                handler(.success(projects))
            }
            if let error = error {
                handler(.failure(error))
            }
        }.resume()
    }
    
    func recomendedProjects(with studentId: Int, handler: @escaping (Result<[Project], Error>) -> Void) {
        guard let url = URL(string: mainPath + Paths.studentRecomendation.rawValue + "\(studentId)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let projects = try? JSONDecoder().decode([Project].self, from: data) else { return }
                handler(.success(projects))
            }
            if let error = error {
                handler(.failure(error))
            }
        }.resume()
    }
}
