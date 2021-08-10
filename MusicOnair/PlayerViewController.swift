//
//  PlayerViewController.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/08/10.
//

import UIKit
import AVFoundation
import Foundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var artworkImg: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackArtist: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    // stored property
    let simplePlayer = SimplePlayer.shared
    let trackInfo : TrackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDataUpdate()
    }
    
    func playerDataUpdate() {
        let currentTrackInfo = simplePlayer.currentItem?.convertToTrack()
        guard let currentTrackMetadata = currentTrackInfo else {
            return }
        
        artworkImg.image = currentTrackMetadata.albumCover
        trackTitle.text = currentTrackMetadata.title
        trackArtist.text = currentTrackMetadata.artist
    }

}
