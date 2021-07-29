//
//  Extention.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/07/29.
//

import UIKit
import AVFoundation

extension AVPlayerItem {
    // 음원 파일의 meta data를 TrackInfo 구조체의 프로퍼티에 맞게 변환하는 함수
    func convertToTrack() -> TrackInfo? {
        let metadataList = asset.metadata
        
        // 정보가 없을 수도 있음; 옵셔널
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackAlbumCover: UIImage?
        
        for metadata in metadataList {
            if let title = metadata.title {
               trackTitle = title
            }
            if let artist = metadata.artist {
                trackArtist = artist
            }
            if let albumName =  metadata.albumName {
                trackAlbumName = albumName
            }
            if let albumCover = metadata.albumCover {
                trackAlbumCover =  albumCover
            }
        }
        // guard- let 옵셔널 바인딩
        guard let title = trackTitle,
              let artist = trackArtist,
              let albumName = trackAlbumName,
              let albumCover = trackAlbumCover else {
            return nil
        }
        return TrackInfo(title: title, artist: artist, albumTitle: albumName, albumCover: albumCover)
    }
}

extension AVMetadataItem {
    var title: String? {
        guard let key = commonKey?.rawValue, key == "title" else {
            return nil
        }
        return stringValue
    }
    
    var artist: String? {
        guard let key = commonKey?.rawValue, key == "artist" else {
            return nil
        }
        return stringValue
    }
    
    var albumName: String? {
        guard let key = commonKey?.rawValue, key == "albumName" else {
            return nil
        }
        return stringValue
    }
    
    var albumCover: UIImage? {
        guard let key = commonKey?.rawValue, key == "albumCover", let data = dataValue, let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
