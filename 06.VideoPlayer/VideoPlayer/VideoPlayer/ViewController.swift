//
//  ViewController.swift
//  VideoPlayer
//
//  Created by tbago on 2019/2/26.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

class ViewController: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet weak var audioStateButton: UIButton!
    
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAudioPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
    }

    func initAudioPlayer() {
        let audioPath = Bundle.main.path(forResource: "live", ofType:"mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch {
            audioPlayer = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
        } catch {
            print("Setting category to playAndRecord failed.")
        }
        
        do {
            try audioSession.setActive(true, options: [AVAudioSession.SetActiveOptions.init(rawValue: 0)])
        } catch {
            print("Setting activity to true failed.")
        }
        
        let image = UIImage(named: "thumb.jpg")!
        let artwork = MPMediaItemArtwork.init(boundsSize: image.size) { (size) -> UIImage in
            return image
        }
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle:"皇后大道东",
            MPMediaItemPropertyArtist:"罗大佑",
            MPNowPlayingInfoPropertyPlaybackRate:1.0,
            MPMediaItemPropertyArtwork:artwork,
            MPMediaItemPropertyPlaybackDuration:audioPlayer?.duration ?? 0,
            MPNowPlayingInfoPropertyElapsedPlaybackTime:audioPlayer?.currentTime ?? 0
        ]
    }
    
    @IBAction func playVideoButtonClick() {
        let videoUrl = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoUrl!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    @IBAction func audioStateButtonClick(_ sender: UIButton) {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.pause()
            sender.setTitle("Play Audio", for: .normal)
        }
        else {
            audioPlayer?.play()
            sender.setTitle("Pause Audio", for: .normal)
        }
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:
            audioPlayer?.play()
        case .remoteControlPause:
            audioPlayer?.pause()
        case .remoteControlStop:
            audioPlayer?.stop()
        default:
            break
        }
    }
}

