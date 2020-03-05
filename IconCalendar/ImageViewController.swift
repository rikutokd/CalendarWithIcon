import UIKit
import RealmSwift

private let job = [
"icons8-googleグループ-100"
,"icons8-paycheque-100"
,"icons8-イベント承認-100"
,"icons8-カスタマー-サポート-100"
,"icons8-クラウド-100"
,"icons8-クラウドファンディング-100"
,"icons8-クラウドへのアップロード-100"
,"icons8-クレジット-コントロール-100"
,"icons8-コミュニケーション-100"
,"icons8-コミュニケーションスキル-100"
,"icons8-コメント-100"
,"icons8-コラボレーション-100"
,"icons8-スカイプ-100"
,"icons8-チケットを渡す-100"
,"icons8-チャット-100"
,"icons8-ビデオ会議-100"
,"icons8-ビデオ通話-100"
,"icons8-ビデオ編集-100"
,"icons8-プレゼン-100"
,"icons8-ボックス-100"
,"icons8-マイトピック-100"
,"icons8-マッチング求人を探す-100"
,"icons8-メッセージを読む-100"
,"icons8-ユーザー-グループの男-100"
,"icons8-ユーザーグループ-100"
,"icons8-会議-100"
,"icons8-会計-100"
,"icons8-会社-100"
,"icons8-空港-100"
,"icons8-群衆-100"
,"icons8-契約-100"
,"icons8-作業-100"
,"icons8-時間とともに-100"
,"icons8-社員カード-100"
,"icons8-取引先-100"
,"icons8-署名-100"
,"icons8-食事-100"
,"icons8-新しい仕事-100"
,"icons8-正社員の職-100"
,"icons8-選挙-100"
,"icons8-超高層ビル-100"
,"icons8-電卓-100"
,"icons8-電話会議-100"
,"icons8-払い戻し-100"
,"icons8-並列タスク-100"
,"icons8-履歴書-100"
,"icons8-領収書-100"
,"icons8-話す男性-100"
]

    private let Foods = [
        "Apple",
        "Asparagus",
"Avocado",
"Baby Bottle",
"Bacon",
"Banana Split",
"Banana",
"Bar",
"Bavarian Beer Mug",
"Bavarian Pretzel"
,"Bavarian Wheat Beer"
,"Beer Bottle"
,"Beer Can"
,"Beer"
,"Beet"
,"Birthday Cake"
,"Bottle of Water"
,"Bread"
,"Broccoli"
,"Cabbage"
,"Cafe"
,"Carrot"
,"Celery"
,"Cheese"
,"Cherry"
,"Chili Pepper"
,"Cinnamon Roll"
,"Citrus"
,"Cocktail"
,"Coconut Cocktail"
,"Coffee Pot"
,"Coffee to Go"
,"Cookies"
,"Corn"
,"Cotton Candy"
,"Crab"
,"Cucumber"
,"Cup"
,"Cupcake"
,"Dim Sum"
,"Dolmades"
,"Doughnut"
,"Dragon Fruit"
,"Durian"
,"Eggplant"
,"Eggs"
,"Espresso Cup"
,"Fish Food"
,"Food And Wine"
,"French Fries"
,"French Press"
,"Garlic"
,"Grapes"
,"Hamburger"
,"Hazelnut"
,"Honey"
,"Hops"
,"Hot Chocolate"
,"Hot Dog"
,"Ice Cream Cone"
,"Ingredients"
,"Kebab"
,"Kiwi"
,"Kohlrabi"
,"Leek"
,"Lettuce"
,"Macaron"
,"Melon"
,"Milk"
,"Nachos"
,"Natural Food"
,"Noodles"
,"Nut"
,"Octopus"
,"Olive Oil"
,"Olive"
,"Onion"
,"Organic Food"
,"Pancake"
,"Paprika"
,"Pastry Bag"
,"Peach"
,"Peanuts"
,"Pear"
,"Peas"
,"Pepper Shaker"
,"Pie"
,"Pineapple"
,"Pizza"
,"Plum"
,"Pomegranate"
,"Porridge"
,"Potato"
,"Prawn"
,"Pretzel"
,"Quesadilla"
,"Rack of Lamb"
,"Radish"
,"Raspberry"
,"Rice Bowl"
,"Sack of Flour"
,"Salt Shaker"
,"Sauce"
,"Sesame"
,"Spaghetti"
,"Spoon of Sugar"
,"Steak"
,"Strawberry"
,"Sugar Cube"
,"Sugar"
,"Sushi"
,"Sweet Potato"
,"Taco"
,"Tapas"
,"Tea Cup"
,"Tea"
,"Teapot"
,"Thanksgiving"
,"Tin Can"
,"Tomato"
,"Vegan Food"
,"Vegan Symbol"
,"Watermelon"
,"Wine Bottle"
,"Wine Glass"
,"Wrap"
]

private let Travel = [
"3StarHotel"
,"4StarHotel"
,"AirplaneFrontView"
,"Archeology"
,"BaggageLockers"
,"BeachBall"
,"BeachUmbrella"
,"Beach"
,"BigBen"
,"Bust"
,"CableCar"
,"Campfire"
,"CampingTent"
,"CoconutCocktail"
,"Colosseum"
,"CruiseShip"
,"CustomsOfficer"
,"Customs"
,"EiffelTower"
,"EntranceVisa"
,"EquestrianStatue"
,"Ferry"
,"FlipFlops"
,"Flippers"
,"HotAirBalloon"
,"HotSprings"
,"HotelInformation"
,"LionStatue"
,"MapMarker"
,"MaskSnorkel"
,"ModernStatue"
,"Monument"
,"Museum"
,"NoBaggage"
,"NoScubaDiving"
,"Obelisk"
,"PalmTree"
,"Passport"
,"PointofInterest"
,"RailroadCar"
,"RVCampground"
,"ScubaDiving"
,"ScubaMask"
,"SeaWaves"
,"Signpost"
,"SkiRental"
,"StatueofLiberty"
,"Statue"
,"Suitcase"
,"Summer"
,"SunLounger"
,"SwimRing"
,"TajMahal"
,"Taxi"
,"TicketPurchase"
,"Ticket"
,"TourBus"
,"TrainTicket"
,"USCapitol"
,"WalkingBridge"
,"WineTour"
,"WorldMap"
,"WorldwideLocation"
,"Zipline"
]

private let titles = ["仕事,コミュニケーション","食べ物","旅行"]

private let titleOfImages = ["icons8-コミュニケーションスキル-100","icons8-食事-100","icons8-空港-100"]

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var pickedDate = ""
    
    var selectedIconArray : [Data] = []
    
    //コールバックする時,引数無し
    var imageViewCallBack: (() -> Void)?
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //collectionview設定
        collectionview.delegate = self
        collectionview.dataSource = self
        
        
        //iOSのモードをライトに
        self.overrideUserInterfaceStyle = .light
        
        //ボタン設定2種
        cancelBtn!.addTarget(self, action: #selector(cancelEvent(_:)), for: .touchUpInside)
        
        addBtn!.addTarget(self, action: #selector(trySave(_:)), for: .touchUpInside)
        
        //追加ボタンを初期でdisable状態に
        addBtn.isEnabled = false
        
    }
    
    //cellの横幅、高さ設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
         let width: CGFloat = 50
           let height: CGFloat = width
           return CGSize(width: width, height: height)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0://job
            return 48
        case 1://食べ物
            return 126
        
        case 2://旅行
            return 64
            
        default:
            print("error")
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
        
        // Tag番号を使ってインスタンスをつくる
                let photoImageView = cell.contentView.viewWithTag(1)  as! UIImageView
                let viewSize:CGFloat = view.frame.size.width/3-2

                photoImageView.frame = CGRect(x: 0, y: 0, width: viewSize, height: viewSize)
                        
        //選択されてハイライトされる
        let selectedImageView = UIView(frame: cell.frame)
        selectedImageView.backgroundColor = .lightGray
        cell.selectedBackgroundView = selectedImageView
        
        
        switch (indexPath.section) {
        case 0://job
            let photoImage = UIImage(named: job[indexPath.row])
            photoImageView.image = photoImage
        case 1://食べ物
            let photoImage = UIImage(named: Foods[indexPath.row])
            photoImageView.image = photoImage
            
        case 2://旅行
            let photoImage = UIImage(named: Travel[indexPath.row])
            photoImageView.image = photoImage
        default:
            print("section error")
        }
        
        return cell
    }
    

    // 水平方向におけるセル間のマージン
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                // セルの左右に
                return 0
        }
    
    // 垂直方向におけるセル間のマージン
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 20
            }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            //外枠のマージン(top , left , bottom , right)
            return UIEdgeInsets(top: 20 , left: 2 , bottom: 20 , right: 2 )
            }
    
    }

extension ImageViewController {
    
    //header設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerSection = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "imageViewHeaderCell", for: indexPath) as! imageViewHeaderCell
    
        headerSection.headerTitle = titles[indexPath.section]
        
        headerSection.headerImage = UIImage(named: "\(titleOfImages[indexPath.section])")!
        
        
        return headerSection
        
        }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        var selectedImage : UIImage?
        var pngSelectedIcon : Data?
        
        switch (indexPath.section) {
        case 0:
            selectedImage = UIImage(named: job[indexPath.row])
        case 1:
            selectedImage = UIImage(named: Foods[indexPath.row])
        case 2:
            selectedImage = UIImage(named: Travel[indexPath.row])
        default:
            print("section error")
        }
        //選択されている画像
        print(selectedImage!)
        
        //選択画像をpngに変換
        pngSelectedIcon = selectedImage!.pngData()
        
        //pngを空配列に格納
        selectedIconArray.append(pngSelectedIcon!)
        
        print(selectedIconArray)
        
        print(pickedDate)
        
        //選択されたら追加ボタンを可能状態に
        addBtn.isEnabled = true
        
    }
    
    @objc func cancelEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func trySave(_ : UIButton) {
        
        let realm = try! Realm()
        
        print("DB書き込み開始")
        
        //日付表示の内容とスケジュール入力の内容が書き込まれる。
        let selectIcon = selectedIconArray.last!
        let Events = [EventModel(value: ["date": pickedDate, "icon": selectIcon])]
        let thisDate = realm.objects(EventModel.self).filter("date == '\(pickedDate)'").first
        let icon = thisDate?.icon
        
        let event_Icon = EventModel()
        event_Icon.icon = selectIcon
        
        print(thisDate as Any)

        try! realm.write {
            
            
                if thisDate == nil {
                
                        realm.add(Events)
                        print("DB書き込み中")
                    
                    //DBをその日付で見た時に、値がnilではない時に,
                }else{
                    
                    if icon == nil {
                        
                        thisDate!.icon = selectIcon
                        print("その日付に書き込み中")
                        
                    }else if icon != nil{
                        
                        thisDate!.icon = selectIcon
                        print("画像を上書き中")
                        
                    }
                    
                }
        
            print("データ書き込み完了")
            //前のページに戻る
            
            self.dismiss(animated: true, completion: {
                self.imageViewCallBack?()
            })
        
        }

    
    }

}
