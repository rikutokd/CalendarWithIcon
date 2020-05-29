//
//  ImageViewHeaderCell.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/02/26.
//  Copyright © 2020 hannet. All rights reserved.
//

import Foundation
import UIKit

class imageViewHeaderCell: UICollectionReusableView {
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var headerTitleImage: UIImageView!
    
    var headerTitle: String! {
        didSet{
            headerTitleLabel.text = headerTitle
        }
    }
    
    var headerImage : UIImage! {
        didSet{
            headerTitleImage.image = headerImage
        }
    }
    

    
}
