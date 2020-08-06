//
//  KeyboardObserver.swift
//  ConnapptivityBaseApp
//
//  Created by Marlo Kessler on 03.06.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
class KeyboardObserver: ObservableObject {
    
    @Binding var keyboardIsShown: Bool
    @Binding var keyboardHeight: CGFloat
    
    init(isShown: Binding<Bool> = Binding(get: { return false }, set: {_ in}),
         height: Binding<CGFloat> = Binding(get: { return 0 }, set: {_ in})) {
        
        _keyboardIsShown = isShown
        _keyboardHeight = height
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        keyboardIsShown = true
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyboardHeight = keyboardHeight
        }
    }

    @objc func keyBoardDidHide(notification: Notification) {
        keyboardIsShown = false
    }
}
