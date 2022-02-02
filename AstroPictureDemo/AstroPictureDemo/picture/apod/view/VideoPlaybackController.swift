//
//  VideoPlaybackController.swift
//  AstroPictureDemo
//
//  Created by Vimlesh Bhatt on 01/02/2022.
//

import YouTubeiOSPlayerHelper
import AVKit
import UIKit

class VideoPlaybackController: UIViewController {
    private let url: URL?

    init(url:URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avPlayer: AVPlayerLayer? = {
        let playerLayer = AVPlayerLayer()
        playerLayer.frame = CGRect(origin: CGPoint(x: 0, y:  20), size: view.bounds.size)
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        return playerLayer
    }()

    private lazy var youtubePlayerView: YTPlayerView = {
        let playerView = YTPlayerView()
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return playerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        guard let url = self.url else { return }
        url.absoluteString.contains(kYouTube) ? playYoutubeVideos() : playVideoUsingAVPLayer()
    }

    private func playVideoUsingAVPLayer() {
        guard let url = self.url, let playerLayer = avPlayer else { return }
        playerLayer.player = AVPlayer(url:url)
        playerLayer.player?.isMuted = false
        playerLayer.player?.seek(to: .zero)
        playerLayer.player?.play()
    }

    private func playYoutubeVideos() {
        youtubePlayerView.load(withVideoId: url?.lastPathComponent ?? "")
    }
}
