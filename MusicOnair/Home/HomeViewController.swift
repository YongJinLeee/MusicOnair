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
            //custom Header View 호출
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            header.update(with: todaysTrack)
            // player invocation
            header.tapHandler = { todaysTrack in
                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
                guard let PlayerViewCtrl = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
                PlayerViewCtrl.simplePlayer.replaceCurrentItem(with: todaysTrack)
                self.present(PlayerViewCtrl, animated: true, completion: nil)
            }
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// protocol이 너무 많거나 길어지면 extention 사용
// HomeView에서 Cell 클릭시 player 띄우기
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //player 활성화 (해당 스토리보드 호출)
        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
        // 특정 indentifier를 가진 ViewConroller의 인스턴스화
        guard let PlayerViewCtrl = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
        
        let currentTrackItem = trackManage.tracks[indexPath.item]
        PlayerViewCtrl.simplePlayer.replaceCurrentItem(with: currentTrackItem)
        
        present(PlayerViewCtrl, animated: true, completion: nil)
    }
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


