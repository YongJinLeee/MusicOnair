//
//  TrackCollectionViewCell.swift
//  MusicOnair
//
//  Created by LeeYongJin on 2021/07/28.
//

import UIKit

// MVVM : View
class TrackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        albumCover.layer.cornerRadius = 4
        artistName.textColor = UIColor.systemGray2
    }
    
    func cellDataUpdate(CellInfo: AlbumInfo) {
        
        songTitle.text = CellInfo.title
        artistName.text = CellInfo.artist
        albumCover.image = CellInfo.trackThumbnail
    }
    
}
