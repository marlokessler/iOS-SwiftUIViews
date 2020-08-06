//
//  Progressbar.swift
//  SupportFiles
//
//  Created by Marlo Kessler on 09.02.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//
//
import SwiftUI

@available(iOS 13.0, *)
public struct Progressbar: View {
    private var progress: CGFloat
    
    private var orientation: Orientation = .horizontal
    
    private var foregroundColor: Color = .blue
    private var backgroundColor: Color = .gray
    
    @State private var total: CGFloat = 0
    
    public var body: some View {
        ZStack(alignment: self.orientation == .horizontal ? .leading : .bottom) {
            Capsule()
                .foregroundColor(backgroundColor)
                .background(GeometryReader { geometry in
                    Rectangle().fill(Color.clear)
                        .preference(key: WidthPreferenceKey.self, value: self.orientation == .horizontal ? geometry.size.width : geometry.size.height)
                })
            
            Capsule()
                .foregroundColor(foregroundColor)
                .frame(height: self.orientation == .vertical ? progress * total : nil)
                .frame(width: self.orientation == .horizontal ? progress * total : nil)

        }.onPreferenceChange(WidthPreferenceKey.self, perform: { width in
            self.total = width
        })
    }
    
    public init(progress: CGFloat) {
        self.progress = progress
    }
    
    private init(_ progress: CGFloat,
                 _ backgroundColor: Color,
                 _ foregroundColor: Color,
                 _ orientation: Orientation) {
        
        self.progress = progress
        
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.orientation = orientation
    }
    
    public func backgroundColor(_ color: Color) -> Progressbar {
        return Progressbar(progress, color, foregroundColor, orientation)
    }
    
    public func foregroundColor(_ color: Color) -> Progressbar {
        return Progressbar(progress, backgroundColor, color, orientation)
    }
    
    public func orientation(_ orientation: Orientation) -> Progressbar {
        return Progressbar(progress, backgroundColor, foregroundColor, orientation)
    }
}
