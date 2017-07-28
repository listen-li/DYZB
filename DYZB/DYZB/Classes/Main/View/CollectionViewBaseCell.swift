//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by admin on 17/7/27.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {
    
    //Mark:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //Mark:- 定义模型属性
    var anchor : AnchorModel? {
        didSet {
            //0.检验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2.昵称额显示
            nickNameLabel.text = anchor.nickname
            
            //3.设置封面图片
            guard  let iocnURL = NSURL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: ImageResource(downloadURL: iocnURL as URL))
        }
    }
}
