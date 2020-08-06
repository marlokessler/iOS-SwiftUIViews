//
//  PartialSheetViewExtension.swift
//  RessourcesFramework
//
//  Created by Marlo Kessler on 23.04.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension View {
    /**
    Presents a **Partial Sheet**  with a dynamic height based on his content.
    - parameter presented: This should be set to true when the Partial Sheet has to be displayed.
    - parameter backgroundColor: The background color for the Sheet. Default is *Color.white*.
    - parameter handlerBarColor:The  color for the Handler Bar. Default is *Color.gray*.
    - parameter enableCover: Enable a cover view under the Sheet. Touching it makes the Sheet disappears.
    Default is *true*.
    - parameter coverColor: The background color for the Cover View. Default is *Color.black.opacity(0.2)*.
    - parameter view: The content to place inside of the Partial Sheet.
    */
    func partialSheet<SheetContent: View>(
        presented: Binding<Bool>,
        backgroundColor: Color = .secondary,
        handlerBarColor: Color = .gray,
        enableCover: Bool = true,
        coverColor: Color = Color.gray.opacity(0.4),
        view: @escaping () -> SheetContent ) -> some View {
        self.modifier(
            PartialSheet(
                presented: presented,
                backgroundColor: backgroundColor,
                handlerBarColor: handlerBarColor,
                enableCover: enableCover,
                coverColor: coverColor,
                view: view
            )
        )
    }
}
