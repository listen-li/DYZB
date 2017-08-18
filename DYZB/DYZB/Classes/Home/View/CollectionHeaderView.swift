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
    @IBOutlet weak var moreBtn: UIButton!
    
    //Mark:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text =  group?.tag_name
            iconImageView.image = UIImage(named:group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}

//Mark:- 从xib中快速创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
    return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
