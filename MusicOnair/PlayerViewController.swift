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
        
        updatePlayBtnUI()
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
    // 재생버튼 토글 isPlaying은 기본적으로 false로 리턴되어있음(extension 파일에 구현)
    @IBAction func togglePlayBtn(_ sender: UIButton) {
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayBtnUI()
    }
    // 재생/멈춤시 play/pause 버튼 이미지 변환
    func updatePlayBtnUI() {
        if simplePlayer.isPlaying {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let pauseImg = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            
            playBtn.setImage(pauseImg, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let playImg = UIImage(systemName: "play.fill", withConfiguration: configuration)
            
            playBtn.setImage(playImg, for: .normal)
        }
    }
    
}
