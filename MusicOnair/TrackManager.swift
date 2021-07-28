//
//  TrackManager.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/07/28.
//

import UIKit
import AVFoundation

// 곡 관리 class. ViewModel
class TrackManager {
    //AVPlayer에서 재생될 곡은 AVPlayerItem으로 표현됨
    var tracks: [AVPlayerItem] = []
    var albums: [AlbumInfo] = []
    // 뮤직플레이어의 프로퍼티에 대해 정의 - 트랙, 앨범 등 + 헤더뷰에 들어갈 오늘의 곡
   
    var todaysPick: AVPlayerItem? // 오늘의 곡
    // init 프로퍼티의 생성자 정의
    
    init() {
        let tracks = loadTrackInfo()
        self.tracks = tracks
        self.albums = loadAlbumInfo(tracks: tracks)
        self.todaysPick = self.tracks.randomElement()
        
    }
    
    func loadTrackInfo() -> [AVPlayerItem] {
        // DB에서 파일 읽기 -> AVPlayerItem 생성
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil)  ?? []
        
//        var trackItems: [AVPlayerItem] = []
//        //url은 여러항목이기 때문에 for로 돌리면서 데이터 로드
//        for url in urls {
//            let Items = AVPlayerItem(url: url)
//            trackItems.append(Items)
//        }
        
        //higher-order Function 고계 함수 : 함수의 인수를 함수로 받을 수 있고 함수를 반환하는 함수
        let trackItems = urls.map { url in
            return AVPlayerItem(url: url)
        }
            return trackItems
    }
    
    func indexOfTrack(at index: Int) -> TrackInfo? {
        return nil
    }
    
    func loadAlbumInfo(tracks: [AVPlayerItem]) -> [AlbumInfo] {
        return []
    }
    
    
    
    
}

//func 플레이어에 트랙 로드

//func 인덱스에 맞는 트랙 로드

// 앨범 정보 트랙에 로드하는 함수
