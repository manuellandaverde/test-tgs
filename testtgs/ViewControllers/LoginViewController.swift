//
//  LoginViewController.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(didTapOnDismissKeyboard(_:))))
        
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(didTapOnLoginButtonAction(_:))))
        
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc func didTapOnLoginButtonAction(_ sender: UITapGestureRecognizer) {
        if let usr = usernameTxt, usr.text!.count > 0, usr.text != "" {
            if let pwd = passwordTxt, pwd.text!.count > 0, pwd.text != "" {
                doLoginProcess(user: usr.text ?? "", password: pwd.text ?? "")
            } else {
                passwordTxt.becomeFirstResponder()
            }
        } else {
            usernameTxt.becomeFirstResponder()
        }
    }
    
    // MARK: - Private
    
    private func doLoginProcess(user: String, password: String ) {
        
        let parameters: [String: String] = ["email": user,
                                            "password": password]
        
        AF.request(Static.shared.loginURL, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        
                        switch response.result {
                                    case .success(_):
                                        do {
                                            let loginData = try JSONDecoder().decode(LoginModel.self, from: response.data!)
                                            Static.shared.loginData = loginData
                                            self.showDashboard()
                                            
                                        } catch (let errorCatch) {
                                            print("Error: \(errorCatch.localizedDescription)")
                                        }
                                        
                                    case .failure(let error):
                                        print(error)
                                    }
                }
    }
    
    private func showDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.dataModel = Static.shared.loginData
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.masksToBounds = true
    }
    
    // MARK: - Helpers
    
    @objc func didTapOnDismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

