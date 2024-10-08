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
            .map { email in
                return Utils.checkValidEmail(email: email)
            }
        
        isPasswordValid = password
            .map { password in
                return Utils.checkValidPassword(password: password)
            }
        
        isSubmitEnabled = Observable.combineLatest(isEmailValid, isPasswordValid) { $0 && $1 }
        
    }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
