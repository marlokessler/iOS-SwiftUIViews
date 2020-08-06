//
//  VideoView.swift
//  PlayerViewTestApp
//
//  Created by Marlo Kessler on 28.12.19.
//  Copyright © 2019 Marlo Kessler. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit

@available(iOS 13.0, *)
public struct VideoView: UIViewControllerRepresentable {
    
    private let player: AVPlayer
    
    private var allowsPictureInPicturePlayback = true
    private var entersFullScreenWhenPlaybackBegins = false
    private var exitsFullScreenWhenPlaybackEnds = false
    private var showsPlaybackControls = true
    
    public init(_ videoURL: URL) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
            try audioSession.setActive(true)
        } catch {}
        
        self.player = AVPlayer(url: videoURL)
    }
    
    private init(_ player: AVPlayer,
                 _ allowsPictureInPicturePlayback: Bool,
                 _ entersFullScreenWhenPlaybackBegins: Bool,
                 _ exitsFullScreenWhenPlaybackEnds: Bool,
                 _ showsPlaybackControls: Bool) {
        
        self.player = player
        self.allowsPictureInPicturePlayback = allowsPictureInPicturePlayback
        self.entersFullScreenWhenPlaybackBegins = entersFullScreenWhenPlaybackBegins
        self.exitsFullScreenWhenPlaybackEnds = exitsFullScreenWhenPlaybackEnds
        self.showsPlaybackControls = showsPlaybackControls
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<VideoView>) -> UIViewController {
        let playerController = AVPlayerViewController()
        setUpView(playerController)
        
        return playerController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<VideoView>) {
        guard let playerController = uiViewController as? AVPlayerViewController else { return }
        setUpView(playerController)
    }
    
    private func setUpView(_ playerController: AVPlayerViewController) {
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = allowsPictureInPicturePlayback
        playerController.entersFullScreenWhenPlaybackBegins = entersFullScreenWhenPlaybackBegins
        playerController.exitsFullScreenWhenPlaybackEnds = exitsFullScreenWhenPlaybackEnds
        playerController.showsPlaybackControls = showsPlaybackControls
    }
    
    public func allowsPictureInPicturePlayback(_ allow: Bool) -> VideoView {
        return VideoView(player, allow, entersFullScreenWhenPlaybackBegins, exitsFullScreenWhenPlaybackEnds, showsPlaybackControls)
    }
    
    public func entersFullScreenWhenPlaybackBegins(_ enter: Bool) -> VideoView {
        return VideoView(player, allowsPictureInPicturePlayback, enter, exitsFullScreenWhenPlaybackEnds, showsPlaybackControls)
    }
    
    public func exitsFullScreenWhenPlaybackEnds(_ exit: Bool) -> VideoView {
        return VideoView(player, allowsPictureInPicturePlayback, entersFullScreenWhenPlaybackBegins, exit, showsPlaybackControls)
    }
    
    public func showsPlaybackControls(_ show: Bool) -> VideoView {
        return VideoView(player, allowsPictureInPicturePlayback, entersFullScreenWhenPlaybackBegins, exitsFullScreenWhenPlaybackEnds, show)
    }
}
