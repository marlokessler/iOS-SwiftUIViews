//
//  VideoCompressor.swift
//  AdminApp
//
//  Created by Marlo Kessler on 02.04.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import Foundation
import AVFoundation

//class VideoCompressor {
//
//    static func compressVideo(video: URL, completion: @escaping (URL?) -> Void) {
//        let fileManager = FileManager.default
//                guard let videosURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//                    print("videosURL == nil")
//                    return
//                }
//                let outputURL = videosURL
//        //            .appendingPathComponent("movies")
//                    .appendingPathComponent(video.pathComponents[video.pathComponents.count - 1])
//                    .appendingPathExtension(FileType.video.rawValue)
//
//        let videoAsset = AVAsset(url: video)
//        guard let exportSession = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetPassthrough) else { return }
//        exportSession.shouldOptimizeForNetworkUse = true
//        exportSession.outputFileType = .mp4
//        exportSession.outputURL = outputURL
//        exportSession.exportAsynchronously {
//            completion(outputURL)
//        }
//    }
    
//    var assetWriter:AVAssetWriter?
//    var assetReader:AVAssetReader?
//    let bitrate:NSNumber = NSNumber(value:250000)
//
//    func compressFile(video: URL, completion: @escaping (URL?) -> Void){
//        print("Start Compression Function")
//        let fileManager = FileManager.default
//        guard let videosURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("videosURL == nil")
//            return
//        }
//        let outputURL = videosURL
////            .appendingPathComponent("movies")
//            .appendingPathComponent(video.pathComponents[video.pathComponents.count - 1])
////            .appendingPathExtension(FileType.video.rawValue)

//        var audioFinished = false
//        var videoFinished = false
//        let asset = AVAsset(url: video);
//        //create asset reader
//        do{
//            print("Try Asset Reader")
//            assetReader = try AVAssetReader(asset: asset)
//        } catch{
//            print("Failed Asset Reader")
//            assetReader = nil
//        }
//        guard let reader = assetReader else{
//            print("Could not initalize asset reader probably failed its try catch")
//            fatalError("Could not initalize asset reader probably failed its try catch")
//        }
//
//
//        let videoTrack = asset.tracks(withMediaType: AVMediaType.video).first!
//        let audioTrack = asset.tracks(withMediaType: AVMediaType.audio).first!
//        print("Tracks added")
//        let videoReaderSettings: [String:Any] =  [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB ]
//        // ADJUST BIT RATE OF VIDEO HERE
//        let videoSettings:[String:Any] = [
//            AVVideoCompressionPropertiesKey: [AVVideoAverageBitRateKey:self.bitrate],
//            AVVideoCodecKey: AVVideoCodecType.h264,
//            AVVideoHeightKey: videoTrack.naturalSize.height,
//            AVVideoWidthKey: videoTrack.naturalSize.width
//        ]
//        print("Video Settings set")
//
////        let audioSettings:[String:Any] = [
////            AVFormatIDKey: kAudioFormatMPEG4AAC,
////            AVSampleRateKey: 44100,
////            AVChannelLayoutKey: audioTrack.,
////            AVEncoderBitRateKey: 128000
////        ]
//        var acl = AudioChannelLayout()
//        acl.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo
//        acl.mChannelBitmap = AudioChannelBitmap(rawValue: UInt32(0))
//        acl.mNumberChannelDescriptions = UInt32(0)
//
//        let acll = MemoryLayout<AudioChannelLayout>.size
//        let audioSettings: [String:Any] = [
//            AVFormatIDKey : UInt(kAudioFormatMPEG4AAC),
//            AVNumberOfChannelsKey : 2,
//            AVSampleRateKey : CompressionConfig.defaultConfig.audioSampleRate,
//            AVEncoderBitRateKey : CompressionConfig.defaultConfig.audioBitrate,
//            AVChannelLayoutKey : NSData(bytes:&acl, length: acll)
//        ]
//        print("Audio Settings set")
//
//        let assetReaderVideoOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: videoReaderSettings)
//        let assetReaderAudioOutput = AVAssetReaderTrackOutput(track: audioTrack, outputSettings: nil)
//        print("Reader set")
//        if reader.canAdd(assetReaderVideoOutput){
//            print("Add assetReaderVideoOutput")
//            reader.add(assetReaderVideoOutput)
//        }else{
//            print("Couldn't add video output reader")
//            fatalError("Couldn't add video output reader")
//        }
//        if reader.canAdd(assetReaderAudioOutput){
//            reader.add(assetReaderAudioOutput)
//        }else{
//            fatalError("Couldn't add audio output reader")
//        }
//
//
//        let audioInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: audioSettings)
//        let videoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
//         videoInput.transform = videoTrack.preferredTransform
//
//
//        let videoInputQueue = DispatchQueue(label: "videoQueue")
//        let audioInputQueue = DispatchQueue(label: "audioQueue")
//        do{
//            print("Try asset writer")
//            assetWriter = try AVAssetWriter(outputURL: outputURL, fileType: AVFileType.mp4)
//        }catch{
//            print("Try asset writer failed")
//            assetWriter = nil
//        }
//        guard let writer = assetWriter else{
//            print("assetWritern was nil")
//            fatalError("assetWriter was nil")
//        }
//
//
//        writer.shouldOptimizeForNetworkUse = true
//        writer.add(videoInput)
//        writer.add(audioInput)
//        writer.startWriting()
//        reader.startReading()
//        writer.startSession(atSourceTime: CMTime.zero)
//        print("Start compressing")
//
//        let closeWriter:() -> Void = {
//            if (audioFinished && videoFinished){
//                self.assetWriter?.finishWriting(completionHandler: {
//                    completion((self.assetWriter?.outputURL)!)
//                })
//                self.assetReader?.cancelReading()
//            }
//        }
//
//        print("Compress Audio")
//        audioInput.requestMediaDataWhenReady(on: audioInputQueue) {
//            while(audioInput.isReadyForMoreMediaData){
//                let sample = assetReaderAudioOutput.copyNextSampleBuffer()
//                if (sample != nil){
//                    audioInput.append(sample!)
//                }else{
//                    audioInput.markAsFinished()
//                    DispatchQueue.main.async {
//                        print("Compress Audio Finished")
//                        audioFinished = true
//                        closeWriter()
//                    }
//                    break
//                }
//            }
//        }
//        print("Compress Video")
//        videoInput.requestMediaDataWhenReady(on: videoInputQueue) {
//            print("Data requested")
//            //request data here
//            while(videoInput.isReadyForMoreMediaData){
//                print("Do Loop")
//                let sample = assetReaderVideoOutput.
//                if (sample != nil){
//                    print("Sample is not  nil")
//                    videoInput.append(sample!)
//                } else {
//                    print("Sample is nil")
//                    videoInput.markAsFinished()
//                    print("Compress Video Finished")
//                    DispatchQueue.main.async {
//                        videoFinished = true
//                        closeWriter()
//                    }
//                    break
//                }
//            }
//        }
//    }
//}




//  Created by Diego Perini, TestFairy
//  License: Public Domain
//
//import AVFoundation
//import AssetsLibrary
//import Foundation
//import QuartzCore
//import UIKit
//
//// Global Queue for All Compressions
//fileprivate let compressQueue = DispatchQueue(label: "compressQueue", qos: .background)
//
//// Angle Conversion Utility
//extension Int {
//    fileprivate var degreesToRadiansCGFloat: CGFloat { return CGFloat(Double(self) * Double.pi / 180) }
//}
//
//// Compression Interruption Wrapper
//class CancelableCompression {
//    var cancel = false
//}
//
//// Compression Error Messages
//struct CompressionError: LocalizedError {
//    let title: String
//    let code: Int
//
//    init(title: String = "Compression Error", code: Int = -1) {
//        self.title = title
//        self.code = code
//    }
//}
//
//// Compression Transformation Configuration
//enum CompressionTransform {
//    case keepSame
//    case fixForBackCamera
//    case fixForFrontCamera
//}
//
//// Compression Encode Parameters
//struct CompressionConfig {
//    let videoBitrate: Int
//    let videomaxKeyFrameInterval: Int
//    let avVideoProfileLevel: String
//    let audioSampleRate: Int
//    let audioBitrate: Int
//
//    static let defaultConfig = CompressionConfig(
//        videoBitrate: 1024 * 750,
//        videomaxKeyFrameInterval: 30,
//        avVideoProfileLevel: AVVideoProfileLevelH264High41,
//        audioSampleRate: 22050,
//        audioBitrate: 80000
//    )
//}
//class S {
//    static var _counter = 0
//    static var counter: Int {
//        S._counter += 1
//        return S._counter
//    }
//}
//// Video Size
//typealias CompressionSize = (width: Int, height: Int)
//
//// Compression Operation (just call this)
//func compressh264VideoInBackground(videoToCompress: URL, destinationPath: URL, size: CompressionSize?, compressionTransform: CompressionTransform, compressionConfig: CompressionConfig, completionHandler: @escaping (URL)->(), errorHandler: @escaping (Error)->(), cancelHandler: @escaping ()->()) -> CancelableCompression {
//    print("1: \(S.counter)")
//    // Globals to store during compression
//    class CompressionContext {
//        var cgContext: CGContext?
//        var pxbuffer: CVPixelBuffer?
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//    }
//    print("2: \(S.counter)")
//    // Draw Single Video Frame in Memory (will be used to loop for each video frame)
//    func getCVPixelBuffer(_ i: CGImage?, compressionContext: CompressionContext) -> CVPixelBuffer? {
//        // Allocate Temporary Pixel Buffer to Store Drawn Image
//        weak var image = i!
//        let imageWidth = image!.width
//        let imageHeight = image!.height
//        print("3: \(S.counter)")
//        let attributes : [AnyHashable: Any] = [
//            kCVPixelBufferCGImageCompatibilityKey : true as AnyObject,
//            kCVPixelBufferCGBitmapContextCompatibilityKey : true as AnyObject
//        ]
//
//        if compressionContext.pxbuffer == nil {
//            CVPixelBufferCreate(kCFAllocatorSystemDefault,
//                                imageWidth,
//                                imageHeight,
//                                kCVPixelFormatType_32ARGB,
//                                attributes as CFDictionary?,
//                                &compressionContext.pxbuffer)
//        }
//        print("4: \(S.counter)")
//        // Draw Frame to Newly Allocated Buffer
//        if let _pxbuffer = compressionContext.pxbuffer {
//            let flags = CVPixelBufferLockFlags(rawValue: 0)
//            CVPixelBufferLockBaseAddress(_pxbuffer, flags)
//            let pxdata = CVPixelBufferGetBaseAddress(_pxbuffer)
//
//            if compressionContext.cgContext == nil {
//                compressionContext.cgContext = CGContext(data: pxdata,
//                                                          width: imageWidth,
//                                                          height: imageHeight,
//                                                          bitsPerComponent: 8,
//                                                          bytesPerRow: CVPixelBufferGetBytesPerRow(_pxbuffer),
//                                                          space: compressionContext.colorSpace,
//                                                          bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//            }
//            print("5: \(S.counter)")
//            if let _context = compressionContext.cgContext, let image = image {
//                _context.draw(image, in: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
//                print("6: \(S.counter)")
//            }
//            else {
//                print("7: \(S.counter)")
//                CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
//                return nil
//            }
//
//            CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
//            return _pxbuffer;
//        }
//        print("8: \(S.counter)")
//        return nil
//    }
//
//    // Asset, Output File
//    let avAsset = AVURLAsset(url: videoToCompress)
//    let filePath = destinationPath
//
//    do {
//        print("9: \(S.counter)")
//        // Reader and Writer
//        let writer = try AVAssetWriter(outputURL: filePath, fileType: AVFileType.mp4)
//        let reader = try AVAssetReader(asset: avAsset)
//
//        // Tracks
//        let videoTrack = avAsset.tracks(withMediaType: AVMediaType.video).first!
//        let audioTrack = avAsset.tracks(withMediaType: AVMediaType.audio).first!
//
//        // Video Output Configuration
//        let videoCompressionProps: Dictionary<String, Any> = [
//            AVVideoAverageBitRateKey : compressionConfig.videoBitrate,
//            AVVideoMaxKeyFrameIntervalKey : compressionConfig.videomaxKeyFrameInterval,
//            AVVideoProfileLevelKey : compressionConfig.avVideoProfileLevel
//        ]
//        print("10: \(S.counter)")
//        let videoOutputSettings: Dictionary<String, Any> = [
//            AVVideoWidthKey : size == nil ? videoTrack.naturalSize.width : size!.width,
//            AVVideoHeightKey : size == nil ? videoTrack.naturalSize.height : size!.height,
//            AVVideoCodecKey : AVVideoCodecType.h264,
//            AVVideoCompressionPropertiesKey : videoCompressionProps
//        ]
//        let videoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoOutputSettings)
//        videoInput.expectsMediaDataInRealTime = false
//
//        let sourcePixelBufferAttributesDictionary: Dictionary<String, Any> = [
//            String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_32RGBA),
//            String(kCVPixelFormatOpenGLESCompatibility) : kCFBooleanTrue
//        ]
//        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoInput, sourcePixelBufferAttributes: sourcePixelBufferAttributesDictionary)
//        print("11: \(S.counter)")
//        videoInput.performsMultiPassEncodingIfSupported = true
//        guard writer.canAdd(videoInput) else {
//            errorHandler(CompressionError(title: "Cannot add video input"))
//            return CancelableCompression()
//        }
//        writer.add(videoInput)
//        print("12: \(S.counter)")
//        // Audio Output Configuration
//        var acl = AudioChannelLayout()
//        acl.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo
//        acl.mChannelBitmap = AudioChannelBitmap(rawValue: UInt32(0))
//        acl.mNumberChannelDescriptions = UInt32(0)
//
//        let acll = MemoryLayout<AudioChannelLayout>.size
//        let audioOutputSettings: Dictionary<String, Any> = [
//            AVFormatIDKey : UInt(kAudioFormatMPEG4AAC),
//            AVNumberOfChannelsKey : UInt(2),
//            AVSampleRateKey : CompressionConfig.defaultConfig.audioSampleRate,
//            AVEncoderBitRateKey : CompressionConfig.defaultConfig.audioBitrate,
//            AVChannelLayoutKey : NSData(bytes:&acl, length: acll)
//        ]
//        let audioInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: audioOutputSettings)
//        audioInput.expectsMediaDataInRealTime = false
//        print("13: \(S.counter)")
//        guard writer.canAdd(audioInput) else {
//            errorHandler(CompressionError(title: "Cannot add audio input"))
//            return CancelableCompression()
//        }
//        writer.add(audioInput)
//
//        // Video Input Configuration
//        let videoOptions: Dictionary<String, Any> = [
//            kCVPixelBufferPixelFormatTypeKey as String : UInt(kCVPixelFormatType_422YpCbCr8_yuvs),
//            kCVPixelBufferIOSurfacePropertiesKey as String : [:]
//        ]
//        let readerVideoTrackOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: videoOptions)
//
//        readerVideoTrackOutput.alwaysCopiesSampleData = true
//        print("14: \(S.counter)")
//        guard reader.canAdd(readerVideoTrackOutput) else {
//            errorHandler(CompressionError(title: "Cannot add video output"))
//            return CancelableCompression()
//        }
//        reader.add(readerVideoTrackOutput)
//
//        // Audio Input Configuration
//        let decompressionAudioSettings: Dictionary<String, Any> = [
//            AVFormatIDKey: UInt(kAudioFormatLinearPCM)
//        ]
//        let readerAudioTrackOutput = AVAssetReaderTrackOutput(track: audioTrack, outputSettings: decompressionAudioSettings)
//
//        readerAudioTrackOutput.alwaysCopiesSampleData = true
//        print("15: \(S.counter)")
//        guard reader.canAdd(readerAudioTrackOutput) else {
//            errorHandler(CompressionError(title: "Cannot add video output"))
//            return CancelableCompression()
//        }
//        reader.add(readerAudioTrackOutput)
//        print("16: \(S.counter)")
//        // Orientation Fix for Videos Taken by Device Camera
//        var appliedTransform: CGAffineTransform
//        switch compressionTransform {
//        case .fixForFrontCamera:
//            appliedTransform = CGAffineTransform(rotationAngle: 90.degreesToRadiansCGFloat).scaledBy(x:-1.0, y:1.0)
//        case .fixForBackCamera:
//            appliedTransform = CGAffineTransform(rotationAngle: 270.degreesToRadiansCGFloat)
//        case .keepSame:
//            appliedTransform = CGAffineTransform.identity
//        }
//
//        // Begin Compression
//        reader.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: avAsset.duration)
//        writer.shouldOptimizeForNetworkUse = true
//        reader.startReading()
//        writer.startWriting()
//        writer.startSession(atSourceTime: CMTime.zero)
//        print("17: \(S.counter)")
//        // Compress in Background
//        let cancelable = CancelableCompression()
//        compressQueue.async {
//            // Allocate OpenGL Context to Draw and Transform Video Frames
//            let glContext = EAGLContext(api: .openGLES2)!
//            let context = CIContext(eaglContext: glContext)
//
//            let compressionContext = CompressionContext()
//            print("18: \(S.counter)")
//            // Loop Video Frames
//            var frameCount = 0
//            var videoDone = false
//            var audioDone = false
//
//            while !videoDone || !audioDone {
//                // Check for Writer Errors (out of storage etc.)
//                if writer.status == AVAssetWriter.Status.failed {
//                    reader.cancelReading()
//                    writer.cancelWriting()
//                    compressionContext.pxbuffer = nil
//                    compressionContext.cgContext = nil
//
//                    if let e = writer.error {
//                        errorHandler(e)
//                        return
//                    }
//                }
//                print("19: \(S.counter)")
//                // Check for Reader Errors (source file corruption etc.)
//                if reader.status == AVAssetReader.Status.failed {
//                    reader.cancelReading()
//                    writer.cancelWriting()
//                    compressionContext.pxbuffer = nil
//                    compressionContext.cgContext = nil
//
//                    if let e = reader.error {
//                        errorHandler(e)
//                        return
//                    }
//                }
//                print("20: \(S.counter)")
//                // Check for Cancel
//                if cancelable.cancel {
//                    reader.cancelReading()
//                    writer.cancelWriting()
//                    compressionContext.pxbuffer = nil
//                    compressionContext.cgContext = nil
//                    cancelHandler()
//                    return
//                }
//
//                // Check if enough data is ready for encoding a single frame
//                if videoInput.isReadyForMoreMediaData {
//                    // Copy a single frame from source to destination with applied transforms
//                    if let vBuffer = readerVideoTrackOutput.copyNextSampleBuffer(), CMSampleBufferDataIsReady(vBuffer) {
//                        frameCount += 1
//                        print("Encoding frame: ", frameCount)
//                        print("21: \(S.counter)")
//                        autoreleasepool {
//                            let presentationTime = CMSampleBufferGetPresentationTimeStamp(vBuffer)
//                            let pixelBuffer = CMSampleBufferGetImageBuffer(vBuffer)!
//
//                            CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue:0))
//
//                            let transformedFrame = CIImage(cvPixelBuffer: pixelBuffer).transformed(by: appliedTransform)
//                            let frameImage = context.createCGImage(transformedFrame, from: transformedFrame.extent)
//                            let frameBuffer = getCVPixelBuffer(frameImage, compressionContext: compressionContext)
//                            print("22: \(S.counter)")
//                            CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//
//                            _ = pixelBufferAdaptor.append(frameBuffer!, withPresentationTime: presentationTime)
//                        }
//                    } else {
//                        print("23: \(S.counter)")
//                        // Video source is depleted, mark as finished
//                        if !videoDone {
//                            videoInput.markAsFinished()
//                        }
//                        videoDone = true
//                    }
//                }
//
//                if audioInput.isReadyForMoreMediaData {
//                    print("24: \(S.counter)")
//                    // Copy a single audio sample from source to destination
//                    if let aBuffer = readerAudioTrackOutput.copyNextSampleBuffer(), CMSampleBufferDataIsReady(aBuffer) {
//                        _ = audioInput.append(aBuffer)
//                        print("25: \(S.counter)")
//                    } else {
//                        print("26: \(S.counter)")
//                        // Audio source is depleted, mark as finished
//                        if !audioDone {
//                            audioInput.markAsFinished()
//                        }
//                        audioDone = true
//                    }
//                }
//
//                // Let background thread rest for a while
//                Thread.sleep(forTimeInterval: 0.001)
//            }
//            print("27: \(S.counter)")
//            // Write everything to output file
//            writer.finishWriting(completionHandler: {
//                print("28: \(S.counter)")
//                compressionContext.pxbuffer = nil
//                compressionContext.cgContext = nil
//                completionHandler(filePath)
//            })
//            print("29: \(S.counter)")
//        }
//        print("30: \(S.counter)")
//        // Return a cancel wrapper for users to let them interrupt the compression
//        return cancelable
//    } catch {
//         print("31: \(S.counter)")
//        // Error During Reader or Writer Creation
//        errorHandler(error)
//        return CancelableCompression()
//    }
//}
