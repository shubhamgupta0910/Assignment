//
//  LoginViewController.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 03/09/24.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoggedIn() {
            navigateToNextScreen()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
        
        // Do any additional setup after loading the view.
        
        // Bind text fields to ViewModel
        emailTextfield.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isSubmitEnabled
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
            })
            .disposed(by: disposeBag)
        
        loginButton.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self else { return }
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            weakSelf.navigateToNextScreen()
            
        }).disposed(by: disposeBag)
    }
    
    private func navigateToNextScreen() {
        self.performSegue(withIdentifier: "login", sender: nil)
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

}

