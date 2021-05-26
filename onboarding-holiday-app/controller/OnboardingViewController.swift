//
//  ViewController.swift
//  onboarding-holiday-app
//
//  Created by sherry on 22/05/2021.
//

import UIKit
import AVFoundation
import Combine

class OnboardingViewController: UIViewController {

    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var GetStartedButton: UIButton!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubcribers = [AnyCancellable]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    
    }
    // 2 func for lifecycle of view controllers
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //for hiding nav bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        removeAppEventsSubscribers()
        removePlayer()
       // print(player,playerLayer)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupViews() {
        GetStartedButton.layer.cornerRadius = GetStartedButton.frame.height / 2
        GetStartedButton.layer.masksToBounds = true
        darkView.backgroundColor = UIColor(white: 0.1 , alpha: 0.4)
    }
    
    private func buildPlayer() -> AVPlayer? {
        guard let filepath = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else {
            return nil }
        let url = URL(fileURLWithPath: filepath)
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
        playvideo()
    }
    private func pauseVideo() {
        player?.pause()
    }
    
   private func setupPlayerIfNeeded() {
       player = buildPlayer()
       playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
            view.layer.sublayers?.contains(layer) == false {
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer =  nil
    }
    private func observeAppEvents() {
        
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _  in
            self?.restartVideo()
           // print("video has ended")
        }.store(in: &appEventSubcribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self ] _ in
            self?.pauseVideo()
            print("will Resign active")
        }.store(in: &appEventSubcribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self ] _ in
            self?.pauseVideo()
            print("will Resign active")
        }.store(in: &appEventSubcribers)
        
    }
    
    
    private func removeAppEventsSubscribers() {
        appEventSubcribers.forEach { subscriber in
            subscriber.cancel()
        }
        
    }
    
    
    
}

