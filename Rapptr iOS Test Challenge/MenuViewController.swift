//
//  ViewController.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Views
    private let chatButton = UIButton()
    private let loginButton = UIButton()
    private let animationButton = UIButton()
    
    private let imageView = UIImageView()
    
    private lazy var chatButtonView = MenuButtonView(frame: .zero, title: "CHAT", imageName: "ic_chat", button: chatButton)
    private lazy var loginButtonView = MenuButtonView(frame: .zero, title: "LOGIN", imageName: "ic_login", button: loginButton)
    private lazy var animationButtonView = MenuButtonView(frame: .zero, title: "ANIMATION", imageName: "ic_animation", button: animationButton)
    
    private let stackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Coding Tasks"
        
        style()
        layout()
        chatButtonAction()
        loginButtonAction()
        AnimationButtonAction()
    }
}

// MARK: - Actions
extension MenuViewController {
    @objc private func didPressChatButton(sender: UIButton) {
       navigationTo(vc: ChatViewController())
    }
    
    private func chatButtonAction() {
        chatButton.addTarget(self, action: #selector(didPressChatButton), for: .touchUpInside)
    }
    
    @objc private func didPressLoginButton(sender: UIButton) {
       navigationTo(vc: LoginViewController())
    }
    
    private func loginButtonAction() {
        loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
    }
    
    @objc private func didPressAnimationButton(sender: UIButton) {
       navigationTo(vc: AnimationViewController())
    }
    
    private func AnimationButtonAction() {
        animationButton.addTarget(self, action: #selector(didPressAnimationButton), for: .touchUpInside)
    }
}

// MARK: - Helper Methods
extension MenuViewController {
    private func navigationTo(vc: UIViewController) {
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true)
    }
    
    private func style() {
        chatButtonView.translatesAutoresizingMaskIntoConstraints = false
        loginButtonView.translatesAutoresizingMaskIntoConstraints = false
        animationButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "bg_home_menu")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(chatButtonView)
        stackView.addArrangedSubview(loginButtonView)
        stackView.addArrangedSubview(animationButtonView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 30),
        ])
    }
}

