//
//  LandingViewModel.swift
//  Unbabel
//
//  Created by Afonso Graça on 18/02/16.
//  Copyright © 2016 Unbabel. All rights reserved.
//

import Foundation
import RxSwift

class SplashViewModel: NSObject {

  var currentState = Variable(State.NotLogged)

  func getUserInfo() {
    if let _ = Globals.username, _ = Globals.authToken {
      userInfoRequest()
    } else {
      currentState.value = .ErrorLoggingIn(error: "Not logged in")
    }
  }
}


// MARK: - Private Requests
extension SplashViewModel {
  private func userInfoRequest() {
  }
}
