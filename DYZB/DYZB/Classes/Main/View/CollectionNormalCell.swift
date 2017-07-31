//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by admin on 17/7/20.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {
    
    //Mark:- 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //Mark:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}
