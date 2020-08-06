//
//  ViewExtension.swift
//  ConnapptivityBaseApp
//
//  Created by Marlo Kessler on 03.06.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    func observeKeyboard(isShown: Binding<Bool> = Binding(get: { return false }, set: {_ in}),
                         height: Binding<CGFloat> = Binding(get: { return 0 }, set: {_ in})) -> some View {
        
        _ = KeyboardObserver(isShown: isShown, height: height)
        
        return self
    }
}
