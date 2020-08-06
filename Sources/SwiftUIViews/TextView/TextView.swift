//
//  TextView.swift
//  SupportFiles
//
//  Created by Marlo Kessler on 23.02.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TextView: UIViewRepresentable {
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var adjustsFontForContentSizeCategory = true
    private var allowsEditingTextAttributes = true
    @Binding private var attributedText: NSAttributedString
    private var autocapitalizationType: UITextAutocapitalizationType = .sentences
    private var autocorrectionType: UITextAutocorrectionType = .default
    private var clearsOnInsertion = false
    private var enablesReturnKeyAutomatically = true
    private var font: UIFont = .systemFont(ofSize: 18)
    private var isEditable = true
    private var keyboardType: UIKeyboardType = .default
    private var placeholder = ""
    private var returnKeyType: UIReturnKeyType = .default
    private var isScrollEnabled = true
    private var isSecureTextEntry = false
    private var isSelectable = true
    @Binding private var text: String
    private var textAlignment: NSTextAlignment = .left
    private var textColor: UIColor = .black
    private var textFieldStyle: TextFieldViewStyle = .plain
    private var textContentType: UITextContentType? = .none
    private var usesStandardTextScaling = true
    
    public init(_ attributedText: Binding<NSAttributedString>) {
        self._attributedText = attributedText
        self._text = Binding<String>(get: {return ""}, set: {_ in})
    }
    
    public init(_ text: Binding<String>) {
        self._text = text
        self._attributedText = Binding<NSAttributedString>(get: {return NSAttributedString()}, set: {_ in})
    }
    
    private init(_ adjustsFontForContentSizeCategory: Bool,
                 _ allowsEditingTextAttributes: Bool,
                 _ attributedText: Binding<NSAttributedString>,
                 _ autocapitalizationType: UITextAutocapitalizationType,
                 _ autocorrectionType: UITextAutocorrectionType,
                 _ clearsOnInsertion: Bool,
                 _ enablesReturnKeyAutomatically: Bool,
                 _ font: UIFont,
                 _ isEditable: Bool,
                 _ keyboardType: UIKeyboardType,
                 _ placeholder: String,
                 _ returnKeyType: UIReturnKeyType,
                 _ isScrollEnabled: Bool,
                 _ isSecureTextEntry: Bool,
                 _ isSelectable: Bool,
                 _ text: Binding<String>,
                 _ textAlignment: NSTextAlignment,
                 _ textColor: UIColor,
                 _ textFieldStyle: TextFieldViewStyle,
                 _ textContentType: UITextContentType?,
                 _ usesStandardTextScaling: Bool) {
        
        self.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        _attributedText = attributedText
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.clearsOnInsertion = clearsOnInsertion
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.font = font
        self.isEditable = isEditable
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        self.isScrollEnabled = isScrollEnabled
        self.isSecureTextEntry = isSecureTextEntry
        self.isSelectable = isSelectable
        _text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.textFieldStyle = textFieldStyle
        self.textContentType = textContentType
        self.usesStandardTextScaling = usesStandardTextScaling
    }
    
    public func makeUIView(context: UIViewRepresentableContext<TextView>) -> UIView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        setUpView(textView)
        return textView
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TextView>) {
        guard let textView = uiView as? UITextView else { return }
        setUpView(textView)
    }
    
    private func setUpView(_ textView: UITextView) {
        //Sets a placeholder if attributedText is empty.
        if attributedText.string.isEmpty && text.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        } else {
            if text.isEmpty {
                textView.attributedText = attributedText
            } else {
                textView.text = text
            }
            textView.textColor = colorScheme == .dark ? .white : .black
        }
        
        textView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
        textView.allowsEditingTextAttributes = allowsEditingTextAttributes
        textView.autocapitalizationType = autocapitalizationType
        textView.autocorrectionType = autocorrectionType
        textView.clearsOnInsertion = clearsOnInsertion
        textView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        textView.font = font
        textView.isEditable = isEditable
        textView.isScrollEnabled = isScrollEnabled
        textView.isSecureTextEntry = isSecureTextEntry
        textView.isSelectable = isSelectable
        textView.keyboardType = keyboardType
        textView.returnKeyType = returnKeyType
        textView.usesStandardTextScaling = usesStandardTextScaling
        textView.textAlignment = textAlignment
        textView.textContentType = textContentType
        textView.usesStandardTextScaling = usesStandardTextScaling
                
        
        switch textFieldStyle {
        case .plain:
            break
        case .roundedBorders(let width, let radius, let color):
            textView.layer.borderColor = color.cgColor
            textView.layer.borderWidth = width
            textView.clipsToBounds = true
            textView.layer.cornerRadius = radius
        case .squaredBorders(let width, let color):
            textView.layer.borderColor = color.cgColor
            textView.layer.borderWidth = width
        }
    }
    
    public func makeCoordinator() -> TextView.Coordinator {
        return Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        private var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.attributedText = textView.attributedText
            parent.text = textView.text
        }
        
        public func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
    }
    
    ///Default is YES.
    public func adjustsFontForContentSizeCategory(_ adjust: Bool) -> TextView {
        return TextView(adjust, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is YES.
    public func allowsEditingTextAttributes(_ allows: Bool) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allows, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is .sentences.
    public func autocapitalizationType(_ type: UITextAutocapitalizationType) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, type, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    public func autocorrectionType(_ type: UITextAutocorrectionType) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, type, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is NO.
    public func clearsOnInsertion(_ clears: Bool = true) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clears, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is YES.
    public func enablesReturnKeyAutomatically(_ enables: Bool) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enables, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is .systemFont(ofSize: 18).
    public func font(_ font: UIFont) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is YES.
    public func editable(_ editable: Bool) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, editable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    public func keyboardType(_ type: UIKeyboardType) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, type, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    public func placeholder(_ text: String) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, text, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    public func returnKeyType(_ type: UIReturnKeyType) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, type, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is YES.
    public func scrollable(_ scrollable: Bool) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, scrollable, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }
    
    ///Default is NO.
    public func preventCopying(_ prevent: Bool = true) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, prevent, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }
    
    ///Default is NO.
    public func disabled(_ disabled: Bool = true) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, !disabled, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

    ///Default is .leading.
    public func multilineTextAlignment(_ alignment: TextAlignment) -> TextView {
        let textAlignment: NSTextAlignment

        switch alignment {
        case .center:
            textAlignment = .center
        case .leading:
            textAlignment = .left
        case .trailing:
            textAlignment = .right
        }

        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, usesStandardTextScaling)
    }

//    public func textColor(_ color: Color) -> TextView {
//        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, color, textFieldStyle, textContentType, usesStandardTextScaling)
//    }

    ///Default is .plain.
    public func textFieldStyle(_ style: TextFieldViewStyle) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, style, textContentType, usesStandardTextScaling)
    }

    ///Default is YES.
    public func usesStandardTextScaling(_ uses: Bool) -> TextView {
        return TextView(adjustsFontForContentSizeCategory, allowsEditingTextAttributes, $attributedText, autocapitalizationType, autocorrectionType, clearsOnInsertion, enablesReturnKeyAutomatically, font, isEditable, keyboardType, placeholder, returnKeyType, isScrollEnabled, isSecureTextEntry, isSelectable, $text, textAlignment, textColor, textFieldStyle, textContentType, uses)
    }
}
