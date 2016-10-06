//
//  State.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation

enum State {
  case NotLogged
  case LoggedIn(user: User)
  case ErrorLoggingIn(error: String)
  case ErrorForgotPassword
  case SuccessForgotPassword

  static var currentUserState: State {
    return .NotLogged
  }
}
