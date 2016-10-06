//
//  LoginViewController.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
  let viewModel = LoginViewModel()

  // MARK: - Labels
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var credentialsStack: UIStackView!
  @IBOutlet weak var emailInputField: UITextField!
  @IBOutlet weak var passwordInputField: UITextField!
  @IBOutlet weak var forgotPasswordButton: UIButton!
  @IBOutlet weak var signInButton: BorderedButton!
  @IBOutlet weak var navigationBar: UINavigationItem!
  let disposeBag = DisposeBag()
  var processingLogIn: ProcessingVisualEffectView?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindViewController()

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
    setupButtons()
  }

  func setupTextFields() {
    emailInputField.delegate = self
    passwordInputField.delegate = self

    emailInputField.placeholder = "Email"
    passwordInputField.placeholder = "Password"
  }

  func setupButtons() {
    forgotPasswordButton.setTitle("Forgot your password?", forState: .Normal)
    signInButton.setTitle("Sign In", forState: .Normal)
  }
}

// MARK: - View Controller - View Model Binding
extension LoginViewController {
  private func bindViewController() {
    viewModel
      .currentState
      .asObservable()
      .subscribeNext { [weak self] event in
        guard let `self` = self else {
          return
        }
        switch event {
        case .LoggedIn:
          self.processingLogIn?.hide()
          self.presentAlert("Sign in Successful", description: "Happy Translations.")
        case .ErrorLoggingIn(_):
          self.processingLogIn?.hide()
          self.presentAlert("Wrong email or password", description: "Please try again.")
        default:
          break
        }
      }
      .addDisposableTo(rx_disposeBag)
  }
}

// MARK: - Actions
extension LoginViewController {
  @IBAction func performLogin(sender: UIButton) {
    login()
  }


  @IBAction func onForgotPasswordTap(sender: UIButton) {
    // TODO: Implementation of resetting password
  }

  private func login() {
    guard let email = emailInputField.text, password = passwordInputField.text else {
      return
    }
    processingLogIn?.message = "Logging In"
    processingLogIn?.show()
    viewModel.login(email, pasword: password)
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

// MARK: - UITextField Methods
extension LoginViewController {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                 replacementString string: String) -> Bool {
    if let currentString = textField.text {
      let currentNSString = currentString as NSString
      let currentText = currentNSString.stringByReplacingCharactersInRange(range,
                                                                           withString: string)

      switch textField {
      case emailInputField:
        if let password = passwordInputField.text
          where Validations.isValidEmail(currentText as String)
          && Validations.isValidPassword(password) {
          signInButton.enabled = true
        }
        else {
          signInButton.enabled = false
        }
      case passwordInputField:
        if let email = emailInputField.text where Validations.isValidEmail(email)
          && Validations.isValidPassword(currentText as String) {
          signInButton.enabled = true
        }
        else {
          signInButton.enabled = false
        }
      default:
        signInButton.enabled = false
      }
    }
    else {
      signInButton.enabled = false
    }
    return true
  }
}
