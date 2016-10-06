//
//  LoginViewModel.swift
//  Unbabel
//
//  Created by Afonso Graça on 15/01/16.
//  Copyright © 2016 Unbabel. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel: NSObject {

  var currentState = Variable(State.currentUserState)

  func login(email: String, pasword: String) {
    loginRequest(email, password: pasword)
  }
}

// MARK: - Requests
extension LoginViewModel {
  private func loginRequest(email: String, password: String) {
    Network.unbabelProvider
      .request(UnbabelAPI.Login(email, password)) // request to the server
      .retry(3) // number of retries
      .subscribe { [weak self] result in
        guard let `self` = self else { return }
        // subscribe defines the next steps (saves the object model to the Model Layer
        switch result {
        case .Error:
          self.currentState.value = .ErrorLoggingIn(error: "Error Logging In")
        case .Next:
          let user = User()

          self.currentState.value = .LoggedIn(user: user)
        case .Completed:
          break
        }

      }
      .addDisposableTo(rx_disposeBag) // add to reactive bag
  }

  private func forgotPasswordRequest(email: String) {
  }
}
