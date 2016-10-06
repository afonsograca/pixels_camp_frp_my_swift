//
//  ProcessingVisualEffectView.swift
//  FRPmySwift
//
//  Created by Afonso Graça on 06/10/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

class ProcessingVisualEffectView: UIVisualEffectView {

  let activityIndicator = UIActivityIndicatorView()
  let messageLabel = UILabel()
  let blurEffect = UIBlurEffect(style: .Dark)

  weak var controller: UIViewController?
  var message: String? {
    get {
      return messageLabel.text
    }
    set {
      messageLabel.text = newValue
      messageLabel.sizeToFit()
    }
  }

  init(controller: UIViewController, message: String) {
    super.init(effect: blurEffect)

    self.controller = controller
    setup()
    self.message = message
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - Setup, show and hide methods
extension ProcessingVisualEffectView {
  func setup() {
    // begin hidden
    effect = nil
    hidden = true

    // Set the background
    let vibrancy = UIVibrancyEffect(forBlurEffect: blurEffect)
    let vibrancyView = UIVisualEffectView(effect: vibrancy)
    vibrancyView.frame = bounds
    vibrancyView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    vibrancyView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(vibrancyView)

    vibrancyView.widthAnchor.constraintEqualToAnchor(contentView.widthAnchor).active = true
    vibrancyView.heightAnchor.constraintEqualToAnchor(contentView.heightAnchor).active = true
    vibrancyView.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor).active = true
    vibrancyView.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor).active = true
    // Rounded Corners
    layer.cornerRadius = 5.0
    layer.masksToBounds = true

    // Label
    messageLabel.numberOfLines = 0
    messageLabel.lineBreakMode = .ByWordWrapping
    messageLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    messageLabel.textColor = UIColor.blackColor()

    setupStackView(vibrancyView.contentView)
    activityIndicator.startAnimating()
  }

  func setupStackView(container: UIView) {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .Horizontal
    stackView.alignment = .Center
    stackView.distribution = .Fill
    stackView.spacing = activityIndicator.layoutMargins.right
    stackView.addArrangedSubview(activityIndicator)
    stackView.addArrangedSubview(messageLabel)

    container.addSubview(stackView)

    let margins = container.layoutMarginsGuide

    stackView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    stackView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    stackView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
    stackView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true

  }

  func show() {
    animateView(hide: false)
  }

  func hide() {
    animateView(hide: true)
  }

  func animateView(hide hide: Bool) {
    if !hide {
      activityIndicator.startAnimating()
      hidden = false
    }

    UIView.animateWithDuration(0.7, animations: {
      if hide {
        self.effect = nil
      } else {
        self.effect = self.blurEffect
      }
    }) { completed in
      if hide {
        self.activityIndicator.stopAnimating()
        self.hidden = true
      }
    }
  }
}

// MARK: - Positioning methods
extension ProcessingVisualEffectView {
  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = superview {

      messageLabel.preferredMaxLayoutWidth = superview.frame.size.width / 2
      // Auto Layout
      translatesAutoresizingMaskIntoConstraints = false
      let margins = superview.layoutMarginsGuide
      contentView.centerXAnchor.constraintEqualToAnchor(margins.centerXAnchor).active = true
      contentView.bottomAnchor.constraintEqualToAnchor(margins.centerYAnchor).active = true
    }
  }
}

// MARK: - Touch events
extension ProcessingVisualEffectView {
  // Since it's only informative, Processing views should not consume touch events
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, withEvent: event)
    return view == contentView ? nil : view
  }
}

