//
//  TrackCollectionHeaderViewCollectionViewController.swift
//  MusicOnair
//
//  Created by LeeYongJin

import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var todayArtworkImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        todayArtworkImg.layer.cornerRadius = 4
    }
    
    
    func update(with item: AVPlayerItem) {
        self.item = item
        
        guard let HeaderTrackInfo = item.convertToTrack() else { return }
        
        self.todayArtworkImg.image = HeaderTrackInfo.albumCover
        self.descriptionLabel.text = "Today's Pick is \(HeaderTrackInfo.artist)'s Album - \(HeaderTrackInfo.albumTitle)"
    }

    @IBAction func tapHeaderBtn(_ sender: UIButton) {
        guard let todaysItem = item else { return }
        
        tapHandler?(todaysItem)
    }
    
}
