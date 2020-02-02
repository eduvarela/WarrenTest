//
//  LoginViewController.swift
//  BuildApp
//

import UIKit
class LoginViewController: UIViewController {
    let emailTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    let loginButton: UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Login"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceivedLoginResult(_:)), name: .didReceivedLoginResult, object: nil)
        
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)

        emailTextField.delegate = self
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.backgroundColor = .black
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Email"
        emailTextField.tintColor = .white
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -23).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.returnKeyType = .done
        
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .black
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Senha"
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 23).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.returnKeyType = .done

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        loginButton.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        
        if let userData = Application.shared.userData{
            ServiceManager.login(email: userData.email, password: userData.password)
        }
    }
    
    @objc func onDidReceivedLoginResult(_ notification:Notification) {
        DispatchQueue.main.async {
            if Application.shared.login != nil{
               let mainViewController = MainViewController()
               self.navigationController?.setViewControllers([mainViewController], animated: true)
            }else{
                let alert = UIAlertController(title: "Login", message: "Login ou senha inválidos!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func performLogin(){
        guard let emailText = emailTextField.text else {
            return
        }
        
        guard let passwordText = passwordTextField.text else {
            return
        }
        
        if emailText.isEmpty || passwordText.isEmpty{
            let alert = UIAlertController(title: "Login", message: "Preencha todos os campos!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        ServiceManager.login(email: emailText, password: passwordText)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return false
    }
}
