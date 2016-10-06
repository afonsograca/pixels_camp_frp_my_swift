//
//  Validations.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation

class Validations {
  class func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)

    return emailTest.evaluateWithObject(email)
  }

  class func isValidPassword(password: String) -> Bool {
    // TODO: Measures need to be implemented on the backend
    return !password.isEmpty
  }
}
