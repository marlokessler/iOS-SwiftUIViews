//
//  ImagePicker.swift
//  IPApp
//
//  Created by Marlo Kessler on 01.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI
import AVKit

public struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding private var image: UIImage?
    @Binding private var url: URL?
    
    private var allowsEditing = false
    private var mediaType: PickerType
    private var qualitiyType: UIImagePickerController.QualityType = .typeHigh
    private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private var foregroundColor: UIColor?
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    //MARK: - Initializer
    public init(image: Binding<UIImage?>) {
        self._image = image
        self._url = Binding<URL?>(get: {return nil}, set: {_ in})
        mediaType = .image
    }
    
    public init(videoURL: Binding<URL?>) {
        self._url = videoURL
        self._image = Binding<UIImage?>(get: {return nil}, set: {_ in})
        mediaType = .video
    }
    
    private init(_ image: Binding<UIImage?>,
                 _ videoURL: Binding<URL?>,
                 _ mediaType: PickerType,
                 _ allowsEditing: Bool,
                 _ qualitiyType: UIImagePickerController.QualityType,
                 _ sourceType: UIImagePickerController.SourceType,
                 _ foregroundColor: UIColor?) {
        
        self._image = image
        self._url = videoURL
        self.mediaType = mediaType
        self.allowsEditing = allowsEditing
        self.qualitiyType = qualitiyType
        self.sourceType = sourceType
        UINavigationBar.appearance().tintColor = foregroundColor
    }
    
    
    
    //MARK: - View builder
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIViewController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.allowsEditing = allowsEditing
        imagePickerController.videoQuality = qualitiyType
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = [mediaType.rawValue]
        return imagePickerController
    }
    
    public func makeCoordinator() -> ImagePicker.Coordinator {
        return Coordinator(parent: self)
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    
    
    // MARK: - Coordinator
    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            UINavigationBar.appearance().tintColor = nil
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            switch parent.mediaType {
            case .image:
                if let uiImage = info[.editedImage] as? UIImage {
                    parent.image = uiImage
                } else if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
            case .video:
                if let url = info[.mediaURL] as? URL {
                    parent.url = url
                }
            }
            UINavigationBar.appearance().tintColor = nil
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    
    // MARK: - Additional methods
    public func allowEditing(_ allow: Bool) -> ImagePicker {
        return ImagePicker($image, $url, mediaType, allow, qualitiyType, sourceType, foregroundColor)
    }
    
    public func qualityType(_ type: UIImagePickerController.QualityType) -> ImagePicker {
        return ImagePicker($image, $url, mediaType, allowsEditing, type, sourceType, foregroundColor)
    }
    
    public func sourceType(_ type: UIImagePickerController.SourceType) -> ImagePicker {
        return ImagePicker($image, $url, mediaType, allowsEditing, qualitiyType, type, foregroundColor)
    }
    
    public func foregroundColor(_ color: UIColor?) -> ImagePicker {
        return ImagePicker($image, $url, mediaType, allowsEditing, qualitiyType, sourceType, color)
    }
}
