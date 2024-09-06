//
//  Utils.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 05/09/24.
//

import Foundation

class Utils {
    
    static func checkValidEmail(email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func checkValidPassword(password: String) -> Bool {
        return password.count >= 8 && password.count <= 15
    }
}
