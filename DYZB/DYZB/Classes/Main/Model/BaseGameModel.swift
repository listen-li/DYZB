//
//  BaseGameModel.swift
//  DYZB
//
//  Created by admin on 17/8/16.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    //Mark:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //Mark:- 构造函数
    override init() {
        
    }
    
    //Mark:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
