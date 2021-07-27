//
//  MusicOnair
//
//  Created by LeeYongJin
//

import UIKit

class  HomeViewController: UIViewController {
    // !!! 곡 트랙관리 객체 추가
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    // cell counting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // how to Viewing cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    //헤더뷰 구성
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
}

// protocol이 너무 많거나 길어지면 extention 사용
extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // cell size [20 - cell - 20 - cell - 20]
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
           //cell간 간격
           let CellSpacing: CGFloat = 20
           // 좌-우 marginal Space
           let inset: CGFloat = 20
           let TitleAreaHeight: CGFloat = 60
           
           let width: CGFloat = (collectionView.bounds.width -  CellSpacing - inset * 2) / 2
           let height: CGFloat = width + TitleAreaHeight
           
           return CGSize(width: width, height: height)
       }
}

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
