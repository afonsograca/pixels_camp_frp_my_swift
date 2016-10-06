//
//  LoginLandingViewController.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

class LoginLandingViewController: UIViewController {

  // MARK: - Labels
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var signUpButton: UIButton!


  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    populateFields()
  }

  override func viewWillAppear(animated: Bool) {
    if navigationItem.title != nil {
      navigationItem.title = nil
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Localisation Methods
  func populateFields() {
    signInButton.setTitle("Sign In", forState: .Normal)
    signUpButton.setTitle("Sign Up", forState: .Normal)
  }

  // MARK: - Navigation
  @IBAction func onSignUpTap(sender: UIButton) {
    // TODO: Sign up workflow
    print("sign up tapped")
  }

//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == StoryboardSegue.Login.SignIn.rawValue {
//      navigationItem.title = tr(L10n.NavigationBack)
//    }
//  }
}
