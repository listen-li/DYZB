//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by admin on 17/7/20.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit


class CollectionPrettyCell: CollectionViewBaseCell {
    
    //Mark:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //Mark:- 定义模型属性
    override var anchor : AnchorModel?{
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
}
