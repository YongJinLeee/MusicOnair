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
        return 0
    }
    
    // how to Viewing cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
    
}
