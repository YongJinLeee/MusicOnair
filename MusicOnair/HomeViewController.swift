//
//  MusicOnair
//
//  Created by LeeYongJin
//

import UIKit

class  HomeViewController: UIViewController {
    // !!! 곡 트랙관리 객체
    let trackManage: TrackManager = TrackManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    // cell counting
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackManage.tracks.count
    }
    
    // how to Viewing cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackCollectionViewCell", for: indexPath) as? TrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        //곡 표시 함수 호출 및 cell에 전달
        let PlayListitem = trackManage.loadTrackByIndex(at: indexPath.item)
        cell.cellDataUpdate(CellInfo: PlayListitem)
        return cell
    }
    
    //헤더뷰 구성
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let todaysTrack = trackManage.todaysPick else {
                return UICollectionReusableView()
            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            header.update(with: todaysTrack)
            
            return header
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


