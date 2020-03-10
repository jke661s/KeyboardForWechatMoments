//
//  KeyboardView.swift
//  KeyboardForWechatMoments
//
//  Created by Jackie Wang on 29/2/20.
//  Copyright © 2020 Jackie Wang. All rights reserved.
//

import UIKit

protocol KeyboardViewDelegate: class {
    func insert()
    func deleteCharacterBeforeCursor()
}

class KeyboardView: UIView {
    
    // UI elements
    fileprivate var deleteButton: KeyButton = {
        let button = KeyButton()
        button.setTitle("delete", for: .normal)
        button.addTarget(self, action: #selector(handleDelete), for: .touchDown)
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    
    var nextKeyboardButton: KeyButton = {
        let button = KeyButton()
        button.setTitle("next", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    
    fileprivate var doneButton: KeyButton = {
        let button = KeyButton()
        button.setTitle("done", for: .normal)
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    
    fileprivate var inputButton: KeyButton = {
        let button = KeyButton()
        button.setTitle("input", for: .normal)
        button.addTarget(self, action: #selector(handleInput), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        return button
    }()
    
    fileprivate lazy var buttonStack = UIStackView(arrangedSubviews: [deleteButton, nextKeyboardButton, doneButton, inputButton])
    
    var textView: UITextView = UITextView()
    
    // Delegate
    weak var delegate: KeyboardViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        buttonStack.axis = .vertical
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 15
        
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.widthAnchor.constraint(equalToConstant: 55).isActive = true
        buttonStack.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        [deleteButton, nextKeyboardButton, doneButton, inputButton].forEach {
            $0.backgroundColor = .yellow
            $0.setTitleColor(.blue, for: .normal)
        }
        
        addSubview(textView)
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            textView.trailingAnchor.constraint(equalTo: buttonStack.leadingAnchor, constant: -15)
        ])
        
    }
    
    // MARK: Public functions
    func setNextKeyboardVisible(_ visible: Bool) {
        nextKeyboardButton.isHidden = !visible
    }
    
    func setInputDeleteButtonEnable(isEnable: Bool) {
        inputButton.isEnabled = isEnable
        deleteButton.isEnabled = isEnable
    }
    
    func setColorScheme(_ colorScheme: ColorScheme) {
        let colorScheme = Colors(colorScheme: colorScheme)
        backgroundColor = colorScheme.backgroundColor
        
        for view in subviews {
            if let button = view as? KeyButton {
                button.setTitleColor(colorScheme.buttonTextColor, for: [])
                button.tintColor = colorScheme.buttonTextColor
                
                button.defaultBackgroundColor = colorScheme.buttonHighlightColor
                button.highlightBackgroundColor = colorScheme.buttonBackgroundColor
            } else if let textview = view as? UITextView {
                textview.backgroundColor = colorScheme.buttonHighlightColor
            }
        }
    }
    
}

// MARK: - Actions
extension KeyboardView {
    
    @objc fileprivate func handleDelete() {
        delegate?.deleteCharacterBeforeCursor()
    }
    
    @objc fileprivate func handleDone() {
        print("Done")
    }
    
    @objc fileprivate func handleInput() {
        setInputDeleteButtonEnable(isEnable: false)
        delegate?.insert()
    }
    
    
}
