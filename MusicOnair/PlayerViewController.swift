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
    
    var isSeeking: Bool = false
    var timeObserver: Any?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updatePlayBtnUI() // play btn UI 초기화
        playerDataUpdate() // 플레이어 아이템 정보 업데이트
        updateCurrentTime(time: CMTime.zero)
        
//        CMTime(seconds: 1, preferredTimescale: 10) // (기준시간, 분할 수)
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main, using: {time in self.updateCurrentTime(time: time)} )
        // DispatchQueue.main -> 스케일링된 시간 마다 UILabel을 계속 업데이트 할 것임을 main Thread에 알리겠다..
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerDataUpdate()
        updateTintColor()
    }
    // player 닫을 때
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        simplePlayer.pause() // 현재 재생중인 곡 멈춤
        simplePlayer.replaceCurrentItem(with: nil) // 현재 트랙 아이템 언로드
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
    // 재생/멈춤시 play/pause 버튼 이미지 변환 (토글 호출 될 때마다)
    func updatePlayBtnUI() {
        if simplePlayer.isPlaying {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40) // size 지정
            let pauseImg = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            
            playBtn.setImage(pauseImg, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let playImg = UIImage(systemName: "play.fill", withConfiguration: configuration)
            
            playBtn.setImage(playImg, for: .normal)
        }
    }
    
    @IBAction func beginDrag(_ sender: UISlider) {
        isSeeking = true
    }
    
    @IBAction func endDrag(_ sender: UISlider) {
        isSeeking = false
        // false 상태에서 탐색 완료 구간에 대한 데이터 넘어가 해당구간을 재생할 수 있도록 해야함(slider 위치도 함께 업데이트)
    }
    // 탐색 버튼 동작(시간정보 파싱)
    @IBAction func seek(_ sender: UISlider) {
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double(sender.value) // 슬라이더 버튼의 위치 값 0...1 사이값
        let seconds = currentItem.duration.seconds * position // 재생위치 찾기. 일종의 퍼센티지 계산같은. 현재 플레이어에 있는 아이템의 전체 길이(초)에 위치를 곱하면 현재 재생하고자 하는 위치 표기
        let time = CMTime(seconds: seconds, preferredTimescale: 100)
        
        simplePlayer.seek(to: time) // 플레이어에 seeking 결과 값 전송해 재생하도록 함
    }
    
    func updateCurrentTime(time: CMTime) {
        currentTime.text = SecondsToString(sec: simplePlayer.currentTime)
        totalTime.text = SecondsToString(sec: simplePlayer.totalDuratiopnTime)
        
        if isSeeking == false {
            // 노래를 들으면서 슬라이더 버튼으로 탐색하면 위치가 변할 때마다 Slider가 업데이트 되어서 노래가 끊기므로
            // isSeeking이 아닌 상태에서만 currentTime 데이터가 업데이트 되도록 구현
            timeSlider.value = Float(simplePlayer.currentTime / simplePlayer.totalDuratiopnTime)
        }
    }
    // seeking slider에서 받은 CMTime 값 string으로 변환하기
    func SecondsToString(sec: Double) -> String {
        guard sec.isNaN == false else {
            return "00:00"
        }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
}

extension PlayerViewController {
 
    func updateTintColor() {
        // slider, play Button의 색상 다크/라이트 모드 대응
        playBtn.tintColor = DefaultStyle.Colors.tint
        timeSlider.tintColor = DefaultStyle.Colors.tint
    }
    
}
