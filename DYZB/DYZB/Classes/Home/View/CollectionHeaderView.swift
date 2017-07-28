//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by admin on 17/7/20.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //Mark:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //Mark:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text =  group?.tag_name
            iconImageView.image = UIImage(named:group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}
