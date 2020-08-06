//
//  SearchBar.swift
//  MyArea
//
//  Created by Marlo Kessler on 21.03.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SearchBar: UIViewRepresentable {

    //variables
    private var autocapitalizationType: UITextAutocapitalizationType = .sentences
    private var autocorrectionType: UITextAutocorrectionType = .default
    private var enablesReturnKeyAutomatically = true
    private var isSecureTextEntry = false
    private var keyboardType: UIKeyboardType = .default
    private var placeholder = "Search"
    private var returnKeyType: UIReturnKeyType = .search
    private var searchBarStyle: UISearchBar.Style = .default
    @Binding private var selectedScopeButtonIndex: Int
    private var showsBookmarkButton = false
    private var showsCancelButton = false
    private var showsScopeBar = false
    private var showsSearchResultsButton = false
    private var scopeButtonTitles = [String]()
    @Binding private var text: String
    private var textContentType: UITextContentType? = .none
    
    //delegate functions handler
    private var onBookmarkButtonClicked: () -> Void = {}
    private var onCancelButtonClicked: () -> Void = {}
    private var onResultsListButtonClicked: () -> Void = {}
    private var onSearchButtonClicked: () -> Void = {}
    
    
    private var delegate: UISearchBarDelegate?
    
    public init(_ text: Binding<String>, delegate: UISearchBarDelegate? = nil) {
        _text = text
        self.delegate = delegate
        
        self._selectedScopeButtonIndex = Binding<Int>(get: {return 0}, set: {_ in})
    }
    
    private init(_ autocapitalizationType: UITextAutocapitalizationType,
                 _ autocorrectionType: UITextAutocorrectionType,
                 _ enablesReturnKeyAutomatically: Bool,
                 _ isSecureTextEntry: Bool,
                 _ keyboardType: UIKeyboardType,
                 _ placeholder: String,
                 _ returnKeyType: UIReturnKeyType,
                 _ searchBarStyle: UISearchBar.Style,
                 _ selectedScopeButtonIndex: Binding<Int>,
                 _ showsBookmarkButton: Bool,
                 _ showsCancelButton: Bool,
                 _ showsScopeBar: Bool,
                 _ showsSearchResultsButton: Bool,
                 _ scopeButtonTitles: [String],
                 _ text: Binding<String>,
                 _ textContentType: UITextContentType?,

                 _ delegate: UISearchBarDelegate?,
                 
                 _ onBookmarkButtonClicked: @escaping () -> Void,
                 _ onCancelButtonClicked: @escaping () -> Void,
                 _ onResultsListButtonClicked: @escaping () -> Void,
                 _ onSearchButtonClicked: @escaping () -> Void) {

        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        self.isSecureTextEntry = isSecureTextEntry
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        self.searchBarStyle = searchBarStyle
        _selectedScopeButtonIndex = selectedScopeButtonIndex
        self.showsBookmarkButton = showsBookmarkButton
        self.showsCancelButton = showsCancelButton
        self.showsScopeBar = showsScopeBar
        self.showsSearchResultsButton = showsSearchResultsButton
        self.scopeButtonTitles = scopeButtonTitles
        _text = text
        self.textContentType = textContentType

        self.delegate = delegate
        
        self.onBookmarkButtonClicked = onBookmarkButtonClicked
        self.onCancelButtonClicked = onCancelButtonClicked
        self.onResultsListButtonClicked = onResultsListButtonClicked
        self.onSearchButtonClicked = onSearchButtonClicked
    }
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        setUpView(searchBar)
        return searchBar
    }

    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        setUpView(uiView)
    }
    
    private func setUpView(_ searchBar: UISearchBar) {
        searchBar.autocapitalizationType = autocapitalizationType
        searchBar.autocorrectionType = autocorrectionType
        searchBar.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        searchBar.isSecureTextEntry = isSecureTextEntry
        searchBar.keyboardType = keyboardType
        searchBar.placeholder = placeholder
        searchBar.returnKeyType = returnKeyType
        searchBar.searchBarStyle = searchBarStyle
        searchBar.selectedScopeButtonIndex = selectedScopeButtonIndex
        searchBar.showsBookmarkButton = showsBookmarkButton
        searchBar.showsCancelButton = showsCancelButton
        searchBar.showsScopeBar = showsScopeBar
        searchBar.showsSearchResultsButton = showsSearchResultsButton
        searchBar.scopeButtonTitles = scopeButtonTitles
        searchBar.text = text
        searchBar.textContentType = textContentType
    }
    
    public func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, UISearchBarDelegate {

        private var parent: SearchBar
        
        init(parent: SearchBar) {
            self.parent = parent
        }
        
        
        public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            parent.delegate?.searchBarShouldBeginEditing?(searchBar) ?? false
        }
        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarTextDidEndEditing?(searchBar)
        }
        public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            parent.delegate?.searchBarShouldEndEditing?(searchBar) ?? false
        }
        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarTextDidEndEditing?(searchBar)
        }
        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.delegate?.searchBar?(searchBar, textDidChange: searchText)
            parent.text = searchText
        }
        public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            parent.delegate?.searchBar?(searchBar, shouldChangeTextIn: range, replacementText: text) ?? false
        }
        
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarSearchButtonClicked?(searchBar)
            parent.onSearchButtonClicked()
        }

        public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarBookmarkButtonClicked?(searchBar)
            parent.onBookmarkButtonClicked()
        }

        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarCancelButtonClicked?(searchBar)
            parent.onCancelButtonClicked()
        }

        public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
            parent.delegate?.searchBarResultsListButtonClicked?(searchBar)
            parent.onResultsListButtonClicked()
        }
        
        public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            parent.delegate?.searchBar?(searchBar, selectedScopeButtonIndexDidChange: selectedScope)
            parent.selectedScopeButtonIndex = selectedScope
        }
    }
    
    public func autocapitalizationType(_ type: UITextAutocapitalizationType) -> SearchBar {
        return SearchBar(type, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func autocorrectionType(_ type: UITextAutocorrectionType) -> SearchBar {
        return SearchBar(autocapitalizationType, type, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func enablesReturnKeyAutomatically(_ enable: Bool) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enable, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func isSecureTextEntry(_ isSecure: Bool) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecure, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func keyboardType(_ type: UIKeyboardType) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, type, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func placeholder(_ placeholder: String) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType,delegate, onBookmarkButtonClicked, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func returnKeyType(_ type: UIReturnKeyType) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, type, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func scopeButtons(_ selected: Binding<Int>, titles: [String]) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, selected, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, titles, $text, textContentType, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func searchBarStyle(_ style: UISearchBar.Style) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, style, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func showsBookmarkButton(_ show: Bool = true, onClick: @escaping () -> Void = {}) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, show, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onClick, onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func showsCancelButton(_ show: Bool = true, onClick: @escaping () -> Void = {}) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, show, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked, onClick, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func showsScopeBar(_ show: Bool) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, show, showsSearchResultsButton, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }

    public func showsSearchResultsButton(_ show: Bool = true, onClick: @escaping () -> Void = {}) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, show, scopeButtonTitles, $text, textContentType, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onClick, onSearchButtonClicked)
    }

    public func textContentType(_ type: UITextContentType) -> SearchBar {
        return SearchBar(autocapitalizationType, autocorrectionType, enablesReturnKeyAutomatically, isSecureTextEntry, keyboardType, placeholder, returnKeyType, searchBarStyle, $selectedScopeButtonIndex, showsBookmarkButton, showsCancelButton, showsScopeBar, showsSearchResultsButton, scopeButtonTitles, $text, type, delegate, onBookmarkButtonClicked,onCancelButtonClicked, onResultsListButtonClicked, onSearchButtonClicked)
    }
}
