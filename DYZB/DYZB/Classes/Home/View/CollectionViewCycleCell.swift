//
//  CollectionViewCycleCell.swift
//  DYZB
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycleCell: UICollectionViewCell {
    //Mark:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Mark:- 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as! URL))
        }
    }
    
    
}
