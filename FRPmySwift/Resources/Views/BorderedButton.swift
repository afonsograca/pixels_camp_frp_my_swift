//
//  BorderedButton.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

//
//  BorderedButton.swift
//  Unbabel
//
//  Created by Afonso Graça on 19/01/16.
//  Copyright © 2016 Unbabel. All rights reserved.
//

import UIKit

@IBDesignable // To change variables in IB
class BorderedButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }

  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else {
        return nil
      }
      return UIColor(CGColor: color)
    }
    set {
      layer.borderColor = newValue?.CGColor
    }
  }

  override var enabled: Bool {
    didSet {
      guard let backgroundColor = backgroundColor else { return }

      if !enabled {
        self.backgroundColor = backgroundColor.colorWithAlphaComponent(0.5)
      }else if !highlighted {
        self.backgroundColor = backgroundColor.colorWithAlphaComponent(1.0)
      }
    }
  }

  override var highlighted: Bool {
    didSet {
      guard let backgroundColor = backgroundColor else { return }

      if highlighted {
        self.backgroundColor = backgroundColor.colorWithAlphaComponent(0.8)
      } else if enabled {
        self.backgroundColor = backgroundColor.colorWithAlphaComponent(1.0)
      }
    }
  }
}
