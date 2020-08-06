//
//  ActivityIndicator.swift
//  SupportFiles
//
//  Created by Marlo Kessler on 30.12.19.
//  Copyright © 2019 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ActivityIndicator: UIViewRepresentable {

    private var color: UIColor = .lightGray
    private var isAnimating = true
    private var style: UIActivityIndicatorView.Style = .medium

    public init() {}
    
    private init(_ color: UIColor,
                 _ isAnimating: Bool,
                 _ style: UIActivityIndicatorView.Style) {
        
        self.color = color
        self.isAnimating = isAnimating
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        setUpView(indicator)
        return indicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        setUpView(uiView)
    }
    
    private func setUpView(_ indicator: UIActivityIndicatorView) {
        indicator.color = color
        
        if isAnimating {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
        
        indicator.style = style
    }
    
    public func foregroundColor(_ color: UIColor) -> ActivityIndicator {
        return ActivityIndicator(color, isAnimating, style)
    }
    
    public func isAnimating(_ animated: Bool = true) -> ActivityIndicator {
        return ActivityIndicator(color, animated, style)
    }
    
    public func style(_ style: UIActivityIndicatorView.Style) -> ActivityIndicator {
        return ActivityIndicator(color, isAnimating, style)
    }
}
