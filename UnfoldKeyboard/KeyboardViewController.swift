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
        keyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        keyboardView.fillSuperView()
        NSLayoutConstraint.activate([
            keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            keyboardView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: inputView.trailingAnchor)
        ])
        keyboardView.setNextKeyboardVisible(needsInputModeSwitchKey)
    }
    
    override var hasFullAccess: Bool
    {
        if #available(iOS 11.0, *){
            return super.hasFullAccess// super is UIInputViewController.
        }
        
        if #available(iOSApplicationExtension 10.0, *){
            if UIPasteboard.general.hasStrings{
                return  true
            }
            else if UIPasteboard.general.hasURLs{
                return true
            }
            else if UIPasteboard.general.hasColors{
                return true
            }
            else if UIPasteboard.general.hasImages{
                return true
            }
            else  // In case the pasteboard is blank
            {
                UIPasteboard.general.string = ""
                
                if UIPasteboard.general.hasStrings{
                    return  true
                }else{
                    return  false
                }
            }
        } else{
            // before iOS10
            return UIPasteboard.general.isKind(of: UIPasteboard.self)
        }
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
       let colorScheme: ColorScheme
      if textDocumentProxy.keyboardAppearance == .dark {
        colorScheme = .dark
      } else {
        colorScheme = .light
      }
      keyboardView.setColorScheme(colorScheme)
    }
    
    fileprivate func setupText() {
        let defaultString = "Please copy the text first, then come here to input."
        let pasteboard = UIPasteboard.general
        if let chars = pasteboard.string {
            keyboardView.textView.text = chars
            text = chars
        } else {
            keyboardView.textView.text = defaultString
            text = defaultString
        }
        
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
