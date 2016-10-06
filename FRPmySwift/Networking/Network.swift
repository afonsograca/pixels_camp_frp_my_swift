//
//  Network.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation
import RxSwift
import Moya


// MARK: Properties
class Network {

  static var unbabelProvider = RxMoyaProvider<UnbabelAPI>(
    endpointClosure: { (target) -> Endpoint<UnbabelAPI> in
      return Endpoint<UnbabelAPI>(URL: target.url,
        sampleResponseClosure: { .NetworkResponse(200, target.sampleData) },
        method: target.method, parameters: target.parameters, parameterEncoding: .JSON,
        httpHeaderFields: target.headers)
    },
    stubClosure: MoyaProvider.DelayedStub(3),
    plugins: [ NetworkActivityPlugin { activity in
      switch activity {
      case .Began:
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
      case .Ended:
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      }
    }]
  )
}
