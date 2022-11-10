//
//  LoginViewController.swift
//  Rapptr iOS Test Challenge
//
//  Created by Mitya Kim on 10/31/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Views
    private let imageView = UIImageView()
    private let loginButton = UIButton()
    private let emailTextField = UITextField()
    private lazy var emailView = TextFieldView(frame: .zero, textField: emailTextField)
    private let passwordTextField = UITextField()
    private lazy var passwordView = TextFieldView(frame: .zero, textField: passwordTextField)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        styleNavigationBar()
        style()
        layout()
        activateLoginButton()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc private func loginButtonTapped() {
        login()
    }
    
    private func activateLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .primaryActionTriggered)
    }
}

// MARK: - Helper Methods
extension LoginViewController {
    private func style() {
        // imageView
        imageView.image = UIImage(named: "img_login")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // emailView
        emailView.backgroundColor = UIColor(named: "view")
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        // emailTextField
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "loginPlaceholderText") ?? .black])
        emailTextField.textColor = UIColor(named: "loginFilledText")
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // passwordTextField
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "loginPlaceholderText") ?? .black])
        passwordTextField.textColor = UIColor(named: "loginFilledText")
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.isSecureTextEntry = true
        
        // passwordView
        passwordView.backgroundColor = UIColor(named: "view")
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        // loginButton
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = UIColor(named: "button")
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(imageView)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // emailView
            emailView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            emailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: 30),
            
            // passwordView
            passwordView.topAnchor.constraint(equalToSystemSpacingBelow: emailView.bottomAnchor, multiplier: 3),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: 30),
            
            // loginButton
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 3),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        LoginClient.shared.login(email: email, password: password) { response, message in
            if message != "Invalid Parameters" {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Welcome to Rapptr!", message: "\(message)\n The API call took: \(response) ms", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.dismiss(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Failed to access", message: "Please check your email and password.\n The API call took: \(response) ms", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//                        self.dismiss(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            }
        } error: { error in
            print(NetworkError.thrownError(error!))
        }
    }
}
// MARK: - Extension TextField
extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
