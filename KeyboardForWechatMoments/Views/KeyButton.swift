//
//  KeyButton.swift
//  KeyboardForWechatMoments
//
//  Created by Jackie Wang on 11/3/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

class KeyButton: UIButton {
  var defaultBackgroundColor: UIColor = .white
  var highlightBackgroundColor: UIColor = .lightGray

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundColor = isHighlighted ? highlightBackgroundColor : defaultBackgroundColor
  }
}

// MARK: - Private Methods
private extension KeyButton {
  func commonInit() {
    layer.cornerRadius = 5.0
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 0, height: 1.0)
    layer.shadowRadius = 0.0
    layer.shadowOpacity = 0.35
  }
}
