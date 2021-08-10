//
//  TrackInfo.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/07/31.
//

import UIKit

//MVVM : Model
struct TrackInfo {
    let title: String
    let artist: String
    let albumTitle: String
    let albumCover: UIImage
    
    init(title: String, artist: String, albumTitle: String, albumCover: UIImage) {
        self.title = title
        self.artist = artist
        self.albumTitle = albumTitle
        self.albumCover = albumCover
    }
}
// MVVM : ViewModel; 데이터처리
struct AlbumInfo {
    let title: String
    let tracks: [TrackInfo]
    
    // 정보가 없을 수도 있는 값들에 대한 옵셔널 처리
    var artist: String? {
        return tracks.first?.artist
    }
    var trackThumbnail: UIImage? {
        return tracks.first?.albumCover
    }
    
    init (title: String, tracks: [TrackInfo]) {
        self.title = title
        self.tracks = tracks
    }
}
