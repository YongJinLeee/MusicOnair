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
    
    var tracks: [AVPlayerItem] = [] // 앨범 내 전체 트랙의 데이터를 갖는 프로퍼티
    var albums: [AlbumInfo] = [] // 앨범 정보 프로퍼티
    
    // 뮤직플레이어의 프로퍼티에 대해 정의 - 트랙, 앨범 등 + 헤더뷰에 들어갈 오늘의 곡
   
    var todaysPick: AVPlayerItem? // 오늘의 곡
    // init 프로퍼티의 생성자 정의
    
    init() {
        let tracks = loadTrackInfo()
        self.tracks = tracks
        self.albums = loadAlbumInfo(tracks: tracks)
        self.todaysPick = self.tracks.randomElement()
        
    }
    // 트랙 로드하기
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
        // 클로저 더 축약할 수 있지 않나..

        let trackItems = urls.map { url in
            return AVPlayerItem(url: url)
        }
            return trackItems
//        축약 가능하지만 의미 불명확..나중에 내가 모른다..
//        let trackItems = urls.map { AVPlayerItem(url: $0)  }
//            return trackItems
        
    }
    // 인덱스에 맞는 트랙 로드하기
    func loadTrackByIndex(at index: Int) -> TrackInfo? {
        
        let playerItem = tracks[index]
        let loadedTrack = playerItem.convertToTrack()
        return loadedTrack
        // style : 반환타입 명시..
    }
    
    func loadAlbumInfo(tracks: [AVPlayerItem]) -> [AlbumInfo] {
        
        let trackList: [TrackInfo] = tracks.compactMap { $0.convertToTrack()  }
        // 앨범 이름을 기준으로 album의 Dictionary 구성
        let albumDics = Dictionary(grouping: trackList, by: { (track) in track.albumTitle  })
        
        //album array (앨범 모음, 관리)
        var albums: [AlbumInfo] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            
            let album = AlbumInfo(title: title, tracks: tracks)
            albums.append(album)
        }
                
        return albums
    }
}

//func 플레이어에 트랙 로드


// 앨범 정보 트랙에 로드하는 함수
