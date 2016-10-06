//
//  SplashViewController.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit
import Async

class SplashViewController: UIViewController {

  var viewModel = SplashViewModel()

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    Async.main {
      self.bindViewController()
      self.gotToNextVC()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func gotToNextVC() {
    viewModel.getUserInfo()
  }
}

// MARK: - View Controller - View Model Binding
extension SplashViewController {
  private func bindViewController() {
    viewModel
      .currentState
      .asObservable()
      .subscribeNext { [weak self] result in
        guard let `self` = self else { return }
        switch result {
        case .LoggedIn:
          // TODO: Perform segue when the app already has the credentials
          break
        case .ErrorLoggingIn:
          self.performSegueWithIdentifier("Landing", sender: nil)
        default:
          break
        }
      }
      .addDisposableTo(rx_disposeBag)
  }
}
