//
//  Utils.swift
//  TestVideo
//
//  Created by daniel romero on 13-07-17.
//  Copyright © 2017 Daniel Romero. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class Utils  {
    
    /** Get numbers of frame from a video
    - Parameter: URL  video
    - Returns: return the numbers of frame
    */
    class func getFramesVideo(url: URL) -> Int {
        let asset = AVAsset(url: url)
        let assetTrack = asset.tracks(withMediaType: AVMediaTypeVideo).first!
        let assetReader = try! AVAssetReader(asset: asset)
        let assetReaderOutputSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: NSNumber(value: kCVPixelFormatType_32BGRA)
        ]
        let assetReaderOutput = AVAssetReaderTrackOutput(track: assetTrack, outputSettings: assetReaderOutputSettings)
        assetReaderOutput.alwaysCopiesSampleData = false
        assetReader.add(assetReaderOutput)
        assetReader.startReading()
        
        var frameCount = 0
        var sample: CMSampleBuffer? = assetReaderOutput.copyNextSampleBuffer()
        
        while (sample != nil) {
            frameCount += 1
            sample = assetReaderOutput.copyNextSampleBuffer()
        }
        
        return frameCount
        
    }

    /** Get image of the video of a certain TimeInterval
    - Parameter: URL video and TimeInterval
    - Returns: return image
    */
    class  func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
        let asset = AVURLAsset(url: url)
        
        let assetIG = AVAssetImageGenerator(asset: asset)
        assetIG.appliesPreferredTrackTransform = true
        assetIG.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels
        
        let cmTime = CMTime(seconds: time, preferredTimescale: 60)
        let thumbnailImageRef: CGImage
        do {
            thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
        } catch let error {
            print("Error: \(error)")
            return nil
        }
        
        return UIImage(cgImage: thumbnailImageRef)
    }
    
    /** Animate imageView
    - Parameter: imageView and duration of the animation
    */
    class  func animateImage(imageView: UIImageView, duration: Double){
        UIView.animate(withDuration: duration, delay: 0.3, options: [.autoreverse, .repeat], animations: {
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(180))
        }, completion: nil)
    }
   
  

}
