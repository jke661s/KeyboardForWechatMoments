//
//  ViewController.swift
//  KeyboardForWechatMoments
//
//  Created by Jackie Wang on 29/2/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "This keyboard is for Wechat user to use when they post a long paragraph in moments to avoid the text being folded.\nIt requires the open access to get the text in your clipboard. Please follow the instructions.\n1. Go to Settings -> General -> Keyboard -> Keyboards -> Add new keyboard. To add this keyboard. \n2. Select UnfoldKeyboard and tick Allow Full Access"
        view.addSubview(label)
        label.fillSuperView()
        
    }


}

