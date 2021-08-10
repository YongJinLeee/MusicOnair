//
//  Extention.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/07/29.
//

import UIKit
import AVFoundation

extension AVPlayerItem {
    
//     var assets: [AVAsset]? = nil // stored property 접근 불가
    
    // 음원 파일의 meta data를 TrackInfo 구조체의 stored 프로퍼티에 맞게 변환하는 함수
    func convertToTrack() -> TrackInfo? {
        let metadataList = asset.metadata
        
        // 정보가 없을 수도 있음; 옵셔널
        var tracktitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackArtwork: UIImage?
        
        // metadata의 정보 ID는 정해져있음 title, artist, albumName, artwork
        // 주의!
        for metadata in metadataList {
            if let title = metadata.title {
               tracktitle = title
            }
            if let artist = metadata.artist {
                trackArtist = artist
            }
            if let albumName =  metadata.albumName {
                trackAlbumName = albumName
            }
            if let artwork = metadata.artwork {
                trackArtwork = artwork
            }
        }
        // guard- let 옵셔널 바인딩
        guard let title = tracktitle,
              let artist = trackArtist,
              let albumName = trackAlbumName,
              let artwork = trackArtwork else {
                return nil
        }
        return TrackInfo(title: title, artist: artist, albumTitle: albumName, albumCover: artwork)
    }
}
// Computed Property
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
    
    var artwork: UIImage? {
        guard let key = commonKey?.rawValue, key == "artwork", let data = dataValue, let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
// 재생 여부확인 property
extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
