//
//  File.swift
//  
//
//  Created by Marlo Kessler on 01.07.20.
//

import Foundation
import AVFoundation

public extension Video {
    
    func toMp4(completionHandler: @escaping ((URL?, Error?) -> Void) = {_,_ in}) {
        let avAsset = AVURLAsset(url: videoURL, options: nil)
                    
        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler(nil, nil)
            return
        }
            
        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let filePath = documentsDirectory.appendingPathComponent("rendered-Video.mp4")
            
        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                completionHandler(nil, error)
            }
        }
            
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range
            
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .failed:
                completionHandler(nil, exportSession.error)
            case .cancelled:
                completionHandler(nil, nil)
            case .completed:
                completionHandler(exportSession.outputURL, nil)
                    
                default: break
            }
        }
    }
}
