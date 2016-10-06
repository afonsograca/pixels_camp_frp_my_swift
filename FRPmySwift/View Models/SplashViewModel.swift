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
//    Network.unbabelProvider
//    .request(UnbabelAPI.GetUser)
//    .retry(maxAttemptCount)
//    .mapObject(User)
//    .subscribe { [weak self] result in
//        guard let `self` = self else { return }
//      switch result {
//      case .Error:
//        self.currentState.value = .ErrorLoggingIn(error: "Error Fetching User")
//      case .Next(let user):
//        if user.identifier != nil && user.authToken != nil {
//          user.saveEventually()
//          self.destinationViewModel = TaskLandingViewModel(user: user)
//          self.currentState.value = .LoggedIn(user: user, firstTime: false)
//        } else {
//          self.currentState.value = .ErrorLoggingIn(error: "Error Fetching User")
//        }
//      default:
//        break
//      }
//    }
//    .addDisposableTo(rx_disposeBag)
  }
}
