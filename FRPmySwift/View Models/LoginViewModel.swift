//
//  LoginViewModel.swift
//  Unbabel
//
//  Created by Afonso Graça on 15/01/16.
//  Copyright © 2016 Unbabel. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class LoginViewModel: NSObject {

  func login(email: String, pasword: String) -> Observable<Response> {
    return loginRequest(email, password: pasword)
  }
}

// MARK: - Requests
extension LoginViewModel {
  private func loginRequest(email: String, password: String) -> Observable<Response> {
    let request = Network.unbabelProvider
      .request(UnbabelAPI.Login(email, password)) // request to the server
      .retry(3) // number of retries
    return request
  }

  private func forgotPasswordRequest(email: String) {
  }
}
