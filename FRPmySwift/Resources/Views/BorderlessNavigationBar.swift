//
//  BorderlessNavigationBar.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation

//
//  BorderlessNavigationBar.swift
//  Unbabel
//
//  Created by Afonso Graça on 19/01/16.
//  Copyright © 2016 Unbabel. All rights reserved.
//

import UIKit

@IBDesignable
class BorderlessNavigationBar: UINavigationBar {

  var imageButton: UIButton?

  func setup() {
    shadowImage = UIImage()
    setBackgroundImage(UIImage(), forBarMetrics: .Default)
    tintColor = UIColor.whiteColor()
  }

  func createButton() -> UIButton {
    let button = UIButton(type: .System)
    button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.setImage(UIImage(named: "userPlaceholderPicture"), forState: .Normal)

    return button
  }

  func loadProfilePicture() {
    if imageButton == nil {
      imageButton = createButton()
    }

  }

  #if !TARGET_INTERFACE_BUILDER
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  #else
  override func prepareForInterfaceBuilder() {
  setup()
  }
  #endif
}
