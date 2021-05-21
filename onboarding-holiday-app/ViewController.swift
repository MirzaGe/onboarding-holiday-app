//
//  ViewController.swift
//  onboarding-holiday-app
//
//  Created by sherry on 22/05/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var GetStartedButton: UIButton!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    // 2 func for lifecycle of view controllers
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for hiding nav bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupPlayerIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupViews() {
        GetStartedButton.layer.cornerRadius = 28
        GetStartedButton.layer.masksToBounds = true
    }
    
    private func buildPlayer() -> AVPlayer? {
        guard let filepath = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else {
            return nil }
        
        let url = URL (fileURLWithPath: filepath)
            let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
        }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playvideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
    }
    private func pauseVideo() {
        player?.pause()
    }
    
    func setupPlayerIfNeeded() {
       player = buildPlayer()
       playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
            view.layer.sublayers?.contains(layer) == false {
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
    }
    
}

