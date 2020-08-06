//
//  DragState.swift
//  RessourcesFramework
//
//  Created by Marlo Kessler on 23.04.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

/// This enum helps to handle the drag state
@available(iOS 13.0, *)
enum DragState {
    case inactive
    case dragging(translation: CGSize)
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
