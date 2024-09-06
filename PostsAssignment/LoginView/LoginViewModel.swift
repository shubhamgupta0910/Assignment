//
//  LoginViewModel.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 03/09/24.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let isEmailValid: Observable<Bool>
    let isPasswordValid: Observable<Bool>
    let isSubmitEnabled: Observable<Bool>
    
    init() {
        isEmailValid = email
            .asObservable()
            .map { email in
                let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
        
        isPasswordValid = password
            .asObservable()
            .map { password in
                return password.count >= 8 && password.count <= 15
            }
        
        isSubmitEnabled = Observable.combineLatest(isEmailValid, isPasswordValid) { $0 && $1 }
        
    }
    
    func loginClicked() {
        
    }
    
}
