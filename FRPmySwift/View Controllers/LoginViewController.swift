//
//  LoginViewController.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class LoginViewController: UIViewController {
  let viewModel = LoginViewModel()

  // MARK: - Labels
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var credentialsStack: UIStackView!
  @IBOutlet weak var emailInputField: UITextField!
  @IBOutlet weak var passwordInputField: UITextField!
  @IBOutlet weak var forgotPasswordButton: UIButton!
  @IBOutlet weak var signInButton: BorderedButton!
  @IBOutlet weak var navigationBar: UINavigationItem!
  var processingLogIn: ProcessingVisualEffectView?
  var loginRequest: Disposable?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

    processingLogIn = ProcessingVisualEffectView(controller: self,
      message: "Logging in")
    if let processingLogIn = processingLogIn {
      view.addSubview(processingLogIn)
    }

  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
  }

  deinit {
    print("deiniting the view")
  }

  // MARK: - Localisation Methods
  func setup() {
    setupTextFields()
    setupRx()
    setupButtons()
  }

  func setupTextFields() {
    emailInputField.placeholder = "Email"
    passwordInputField.placeholder = "Password"
  }

  func setupButtons() {
    forgotPasswordButton.setTitle("Forgot your password?", forState: .Normal)
    signInButton.setTitle("Sign In", forState: .Normal)
  }
}

// MARK: - Rx setup (FRP)
extension LoginViewController {
  func setupRx() {
    setupRxSignInButton()
    setupRxLogin()
  }

  func setupRxSignInButton() {
    // first I will create some intermediate variable, you know for readability
    let isEmailValid = emailInputField.rx_text
      .debounce(0.5, scheduler: MainScheduler.instance)
      .map(Validations.isValidEmail)
    let isPasswordValid = passwordInputField.rx_text
      .debounce(0.5, scheduler: MainScheduler.instance)
      .map(Validations.isValidPassword)

    Observable.combineLatest(isEmailValid, isPasswordValid) { $0 && $1 }
      .bindTo(signInButton.rx_enabled)
      .addDisposableTo(rx_disposeBag)
  }

  func setupRxLogin() {
    let request = signInButton.rx_tap
      .flatMapLatest { [weak self] _ -> Observable<Response> in
        guard let `self` = self, email = self.emailInputField.text,
          password = self.passwordInputField.text else { return Observable.never() }
        self.processingLogIn?.message = "Logging In"
        self.processingLogIn?.show()
        return self.viewModel.login(email, pasword: password)
      }
      .subscribe { [weak self] result in
        guard let `self` = self else { return }
        switch result {
        case .Next:
          self.processingLogIn?.hide()
          self.presentAlert("Sign in Successful", description: "Happy Translations.")
        case .Error:
          self.processingLogIn?.hide()
          self.presentAlert("Wrong email or password", description: "Please try again.")
        default:
          break
        }
    }
  }
}

// MARK: - Actions
extension LoginViewController {
  @IBAction func onForgotPasswordTap(sender: UIButton) {
    // TODO: Implementation of resetting password
  }
}

// MARK: - Alerts
extension LoginViewController {
  func presentAlert(title: String?, description: String?) {
    let action = UIAlertController(title: title, message: description, preferredStyle: .Alert)
    let dismiss = UIAlertAction(title: "Ok", style: .Default, handler: nil)
    action.addAction(dismiss)
    presentViewController(action, animated: true, completion: nil)
  }
}
