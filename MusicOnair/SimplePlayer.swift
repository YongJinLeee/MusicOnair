//
//  SimplePlayer.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/08/10.
//
// Fast Campus Reference 사용
// 코드 저작권 표기
//  Copyright © 2020 com.joonwon. All rights reserved.

import AVFoundation

class SimplePlayer {
    
    //SimplePlayer class의 인스턴스 생성
    static let shared = SimplePlayer()
    // AVFoundation 모듈의 AVPlayer class 인스턴스 생성
    private let player = AVPlayer()
    
    // 트랙의 현재 재생시간 가져오기
    var currentTime: Double {
        return player.currentItem?.currentTime().seconds ?? 0
    }
    // 트랙의 총 재생 시간
    var totalDuratiopnTime: Double {
        return player.currentItem?.duration.seconds ?? 0
    }
    // Extension AVPlayer -> isPlaying
    var isPlaying: Bool {
        return player.isPlaying
    }
    // 현재 트랙 가져오기
    var currentItem: AVPlayerItem? {
        return player.currentItem
    }
    
    init() {  }
    
    // 일시정지 함수
    func pause() {
        player.pause()
    }
    // 재생
    func play() {
        player.play()
    }
    // 재생시간 탐색
    func seek(to time:CMTime) {
        player.seek(to: time)
    }
    // 탐색된 시간(지정된 구간)에 따른 호출 동작
    func addPeriodicTimeObserver(forInterval: CMTime,
                           queue: DispatchQueue?,
                           using: @escaping (CMTime) -> Void) {
        player.addPeriodicTimeObserver(forInterval: forInterval, queue: queue, using: using)
    }

}
