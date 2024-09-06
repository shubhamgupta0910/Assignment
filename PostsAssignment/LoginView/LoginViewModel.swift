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
                return Utils.checkValidEmail(email: email)
            }
        
        isPasswordValid = password
            .asObservable()
            .map { password in
                return Utils.checkValidPassword(password: password)
            }
        
        isSubmitEnabled = Observable.combineLatest(isEmailValid, isPasswordValid) { $0 && $1 }
        
    }
}
