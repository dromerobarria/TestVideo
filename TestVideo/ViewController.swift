//
//  ViewController.swift
//  TestVideo
//
//  Created by daniel romero on 12-07-17.
//  Copyright © 2017 Daniel Romero. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    var playerLayer: AVPlayer?
    var fileURL: URL?
    var numberOfFrames: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideoLocal()
        addImage()
        //let image = Utils.imageFromVideo(url: fileURL!, at: 6)
        //numberOfFrames = Utils.getFramesVideo(url: fileURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Load video and play it
    func loadVideoLocal(){
        let path = Bundle.main.path(forResource: Video.videoName, ofType: Video.videoFormat)
        fileURL = URL(fileURLWithPath: path!)
        self.playerLayer = AVPlayer(url: fileURL!)
        let playerLayer = AVPlayerLayer(player: self.playerLayer)
        playerLayer.frame = self.view!.bounds
        self.view.layer.addSublayer(playerLayer)
        self.playerLayer?.play()
    }

    //Add image and animate it
    func addImage(){
        let imageName = Video.imageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: view.frame.midX, y: view.frame.midY, width: 100, height: 100)
        view.addSubview(imageView)
      
        Utils.animateImage(imageView: imageView, duration: 10)
    }
    

}

