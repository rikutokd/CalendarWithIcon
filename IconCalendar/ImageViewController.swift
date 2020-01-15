import UIKit

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18 // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
        cell.backgroundColor = .red  // セルの色
        return cell
    }
    
    
//    private let photos = ["Airplane",
//                          "Train",
//                          "Hotel",]
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
//    }
//
//    // セル（要素）に表示する内容
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // "Cell" の部分は　Storyboard でつけた cell の identifier。
//        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//
//        // Tag番号を使ってインスタンスをつくる
//        let photoImageView = cell.contentView.viewWithTag(1)  as! UIImageView
//        let photoImage = UIImage(named: photos[indexPath.row])
//        photoImageView.image = photoImage
//
//        return cell
//    }
    
}

