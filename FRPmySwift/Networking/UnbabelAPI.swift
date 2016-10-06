//
//  UnbabelAPI.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation
import Moya

enum UnbabelAPI {

  case Login(String, String)
}

extension UnbabelAPI: TargetType {
  var baseURL: NSURL { return NSURL(string: "http://unbabel.xyz")! }

  var path: String {
    switch self {
    case .Login:
      return "login/"
    }
  }

  var method: Moya.Method {
    switch self {
    case .Login:
      return .POST
    }
  }

  var parameters: [String: AnyObject]? {
    switch self {
    case .Login(let email, let password):
      return ["email": email, "password": password]
    }
  }

  var sampleData: NSData {
    switch self {
    case .Login:
      return NSData()
    }
  }

  var url: String {
    return baseURL.URLByAppendingPathComponent(path)!.absoluteString!
  }

  var requiresAuthentication: Bool {
    switch self {
    case .Login:
      return false
    }
  }

  var headers: [String: String]? {
    return nil
  }

  var multipartBody: [Moya.MultipartFormData]? {
    return nil
  }
}
