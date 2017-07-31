//
//  AnchorGroup.swift
//  DYZB
//
//  Created by admin on 17/7/25.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //改组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_name = "home_header_normal"
    //游戏对应的图标
    var icon_url : String = ""
    
    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //Mark:- 构造函数
    override init() {
    
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
