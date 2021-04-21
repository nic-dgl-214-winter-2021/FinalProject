//
//  ViewController.swift
//  IOSProject
//
//  Created by Ryan Stich on 2021-03-12.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //There may be better ways to manage this. See for example: https://blog.untitledkingdom.com/how-to-manage-customised-views-in-the-ios-app-with-themes-cb9eef2d47dc
        signUpButton.layer.cornerRadius = 10.0
        loginButton.layer.cornerRadius = 10.0
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor.white.cgColor
        signUpButton.alpha = 0.95
        loginButton.alpha = 0.95
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Manage video
        
        setUpVideo()
    }


    func setUpVideo() {
        
        let videoLocalPath = Bundle.main.path(forResource: "appbg", ofType: "mp4")
        
        // create url
        let url = URL(fileURLWithPath: myPath!)

        // create item
        let item = AVPlayerItem(url: url)

        //creating video player
        videoPlayer = AVPlayer(playerItem: item)

        // creating layer
        // What if something fails?
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.playImmediately(atRate: 1)
        
    }
}

