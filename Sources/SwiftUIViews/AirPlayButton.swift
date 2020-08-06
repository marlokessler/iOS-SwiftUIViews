//
//  AirPlayButton.swift
//  SupportFiles
//
//  Created by Marlo Kessler on 19.02.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import AVKit
import SwiftUI

@available(iOS 13.0, *)
public struct AirPlayButton: UIViewRepresentable {
        
    public init() {}
    
    public func makeUIView(context: UIViewRepresentableContext<AirPlayButton>) -> UIView {
        return AVRoutePickerView()
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AirPlayButton>) {}
}
