//
//  Globals.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

// MARK: - Import Dependency Extensions
import RxCocoa
import NSObject_Rx
import Foundation
import KeychainSwift

class Globals {

  private static var userDefaults: NSUserDefaults {
    guard let defaults = NSUserDefaults(suiteName: "group.com.afonsograca.frpmyswift") else {
      return NSUserDefaults()
    }
    return defaults
  }
  private static let keychain = KeychainSwift()

  static var authToken: String? {
    get {
      return keychain.get("authToken")
    }
    set {
      if let userToken = newValue {
        keychain.set(userToken, forKey: "authToken")
      } else {
        keychain.delete("authToken")
      }
    }
  }

  static var username: String? {
    get {
      return keychain.get("username")
    }
    set {
      if let userToken = newValue {
        keychain.set(userToken, forKey: "username")
      } else {
        keychain.delete("username")
      }
    }
  }

  static var deviceToken: String? {
    get {
      return keychain.get("deviceToken")
    }
    set {
      if let deviceToken = newValue {
        keychain.set(deviceToken, forKey: "deviceToken")
      } else {
        keychain.delete("deviceToken")
      }
    }
  }

}
