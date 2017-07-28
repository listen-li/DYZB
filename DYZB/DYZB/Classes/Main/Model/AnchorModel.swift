//
//  AnchorModel.swift
//  DYZB
//
//  Created by admin on 17/7/25.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id = 0
    //房间图片对应的url
    var vertical_src : String = ""
    //判断是电脑直播还是手机直播
    //0：电脑直播    1：手机直播
    var isVertical : Int = 0
    // 房间名称
    var room_name : String = ""
    //主播昵称
    var nickname : String = ""
    //所在城市
    var anchor_city : String = ""
    //观看人数
    var online : Int = 0
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
//    override func setValue(_ value: Any?, forKey key: String) {
//        
//    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
