//
//  AuthMainView.swift
//  CWChooser
//
//  Created by Виктор Поволоцкий on 11.02.2023.
//

import Foundation
import UIKit
import Combine
import WebKit

final class AuthMainView: UIView {
    
    typealias LOC = Localization.AuthViewController
    private let grid = Grid()
    private var buttonSubject: PassthroughSubject<UserModel, Never>?
    
    /// Картинка воронов
    private let crowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.crowImage)
        return imageView
    }()
    
    /// Кнопка авторизации
    private let authButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LOC.titleButtonAuth, for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(named: Constants.buttonBackground)
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()
    
//    /// Заголовок над кнопкой ввода логина
//    private let titleLoginLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .systemGray
//        label.text = LOC.titleLogin
//        return label
//    }()
//
//    /// Поле ввода логина
//    private let loginInputField: UITextField = {
//        let field = UITextField()
//        field.translatesAutoresizingMaskIntoConstraints = false
//        field.layer.cornerRadius = Constants.cornerRadius
//        field.clipsToBounds = true
//        field.layer.borderWidth = 0.2
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.textColor = .white
//        field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
//        field.attributedPlaceholder = NSAttributedString(
//            string: LOC.fieldLoginText,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
//        )
//        return field
//    }()
//
//    /// Заголовок над кнопкой ввода пароля
//    private let titlePasswordLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .systemGray
//        label.text = LOC.titlePassword
//        return label
//    }()
//
//    /// Поле ввода пароля
//    private let passwordInputField: UITextField = {
//        let field = UITextField()
//        field.translatesAutoresizingMaskIntoConstraints = false
//        field.isSecureTextEntry = true
//        field.layer.cornerRadius = Constants.cornerRadius
//        field.clipsToBounds = true
//        field.layer.borderWidth = 0.2
//        field.layer.borderColor = UIColor.systemGray.cgColor
//        field.textColor = .white
//        field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
//        field.attributedPlaceholder = NSAttributedString(
//            string: LOC.fieldPasswordText,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
//        )
//        return field
//    }()
    
    convenience init(
        frame: CGRect,
        buttonSubject: PassthroughSubject<UserModel, Never>?
    ) {
        self.init(frame: frame)
        self.buttonSubject = buttonSubject
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: Constants.background)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthMainView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url, url.absoluteString == "http://84.201.135.211:8002/" {
            DispatchQueue.main.async {
                webView.isHidden = true
            }
            guard let userUrl = URL(string: "http://84.201.135.211:8002/get_username") else { return }
            var request = URLRequest(url: userUrl)
            request.httpMethod = "GET"
            webView.load(request)
            let store = webView.configuration.websiteDataStore.httpCookieStore
            store.getAllCookies { cookies in
//                let domainCookies = cookies.filter { c in c.domain == "84.201.135.211:8000/"}
                let headers = HTTPCookie.requestHeaderFields(with: cookies)
                var request = URLRequest(url: userUrl)
                request.allHTTPHeaderFields = headers
                URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    if let data = data {
                        guard let user = try? JSONDecoder().decode([UserModel].self, from: data).first else { return }
                        self?.buttonSubject?.send(user)
                    }
                }.resume()
            }
        }
    }
}

private extension AuthMainView {
    enum Constants {
        static let crowImage: String = "hseCrow"
        static let background: String = "hseBackground"
        static let buttonBackground: String = "HseBlue"
        static let heightField: CGFloat = 40
        static let heightButton: CGFloat = 50
        static let verticalItemOffset: CGFloat = 24
        static let topImageOffset: CGFloat = 280
        static let heightImage: CGFloat = 180
        static let cornerRadius: CGFloat = 12
    }
    
    func setupLayout() {
        addSubview(crowImage)
//        addSubview(titleLoginLabel)
//        addSubview(loginInputField)
//        addSubview(titlePasswordLabel)
//        addSubview(passwordInputField)
        addSubview(authButton)
        addSubview(webView)
        webView.isHidden = true
        
        NSLayoutConstraint.activate([
            crowImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topImageOffset),
            crowImage.heightAnchor.constraint(equalToConstant: Constants.heightImage),
            crowImage.widthAnchor.constraint(equalToConstant: Constants.topImageOffset),
            crowImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            titleLoginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xlargeOffset),
//            titleLoginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xlargeOffset),
            
//            loginInputField.topAnchor.constraint(equalTo: titleLoginLabel.bottomAnchor, constant: grid.largeOffset),
//            loginInputField.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
//            loginInputField.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
//            loginInputField.heightAnchor.constraint(equalToConstant: Constants.heightField),
            
//            titlePasswordLabel.topAnchor.constraint(equalTo: loginInputField.bottomAnchor, constant: Constants.verticalItemOffset),
//            titlePasswordLabel.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
//            titlePasswordLabel.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
            
//            passwordInputField.topAnchor.constraint(equalTo: titlePasswordLabel.bottomAnchor, constant: grid.largeOffset),
//            passwordInputField.leadingAnchor.constraint(equalTo: titleLoginLabel.leadingAnchor),
//            passwordInputField.trailingAnchor.constraint(equalTo: titleLoginLabel.trailingAnchor),
//            passwordInputField.heightAnchor.constraint(equalToConstant: Constants.heightField),
            
            authButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -grid.largeOffset),
//            authButton.topAnchor.constraint(equalTo: passwordInputField.bottomAnchor, constant: Constants.verticalItemOffset),
            authButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: grid.xxxlargeOffset),
            authButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -grid.xxxlargeOffset),
            authButton.heightAnchor.constraint(equalToConstant: Constants.heightButton),
            
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    func tapOnButton() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        guard let url = URL(string: "http://84.201.135.211:8002/accounts/yandex/login/?process=login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        webView.load(request)
        DispatchQueue.main.async { [weak self] in
            self?.webView.isHidden = false
        }
    }
}

/// 
