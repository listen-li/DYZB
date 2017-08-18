//
//  CollectionViewGameCell.swift
//  DYZB
//
//  Created by admin on 17/7/31.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewGameCell: UICollectionViewCell {

    //Mark:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //Mark:- 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let iconURL = NSURL(string: baseGame?.icon_url ?? "")
            
            if iconURL == nil {
                iconImageView.image = UIImage(named: "discovery_moreGeme")
            }else{
                iconImageView.kf.setImage(with: ImageResource(downloadURL: iconURL as! URL))
            }
        }
    }
    
    
    //Mark:- 系统函数回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
