//
//  KeyboardViewController.swift
//  UnfoldKeyboard
//
//  Created by Jackie Wang on 29/2/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    // UI Components
    let keyboardView: KeyboardView = KeyboardView()
    
    var timer: Timer?
    var indexNow = 0
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupText()
    }
    
    // MARK: Init
    fileprivate func setupView() {
        guard let inputView = inputView else { return }
        keyboardView.delegate = self
        inputView.addSubview(keyboardView)
        keyboardView.fillSuperView()
        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: inputView.trailingAnchor)
        ])
        keyboardView.setNextKeyboardVisible(needsInputModeSwitchKey)
    }
    
    fileprivate func setupText() {
        let chars = "Test"
        keyboardView.textView.text = chars
        text = chars
    }
    
    
}

extension KeyboardViewController: KeyboardViewDelegate {
    
    func insert() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleInsert), userInfo: nil, repeats: true)
    }
    
    func deleteCharacterBeforeCursor() {
      textDocumentProxy.deleteBackward()
    }
    
    @objc fileprivate func handleInsert() {
        let charArray = Array(text)
        guard indexNow < charArray.count else {
            timer?.invalidate()
            indexNow = 0
            keyboardView.setInputDeleteButtonEnable(isEnable: true)
            return
        }
        self.textDocumentProxy.insertText(String(charArray[indexNow]))
        indexNow = indexNow + 1
    }
    
}
