//
//  File.swift
//  KeyboardForWechatMoments
//
//  Created by Jackie Wang on 10/3/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

enum ColorScheme {
  case dark
  case light
}

struct Colors {
  let buttonTextColor: UIColor
  let buttonBackgroundColor: UIColor
  let buttonHighlightColor: UIColor
  let backgroundColor: UIColor

  init(colorScheme: ColorScheme) {
    switch colorScheme {
    case .light:
      buttonTextColor = .black
      buttonBackgroundColor = .white
      buttonHighlightColor = UIColor(red: 174/255, green: 179/255, blue: 190/255, alpha: 1.0)
      backgroundColor = UIColor(red: 210/255, green: 213/255, blue: 219/255, alpha: 1.0)
    case .dark:
      buttonTextColor = .white
      buttonBackgroundColor = UIColor(white: 138/255, alpha: 1.0)
      buttonHighlightColor = UIColor(white: 104/255, alpha: 1.0)
      backgroundColor = UIColor(white:89/255, alpha: 1.0)
    }
  }
    
}
