//
//  TextFieldViewStyle.swift
//  RessourcesFramework
//
//  Created by Marlo Kessler on 23.04.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public enum TextFieldViewStyle {
    case plain
    case roundedBorders(width: CGFloat = 1, radius: CGFloat =  5, color: UIColor = UIColor.lightGray)
    case squaredBorders(width: CGFloat = 1, color: UIColor = UIColor.lightGray)
}
