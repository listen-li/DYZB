//
//  CycleModel.swift
//  DYZB
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //标题
    var title : String = ""
    //显示的图片地址
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [NSString : NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room as [String : NSObject])
        }
    }
    //主播信息对应的模型对象
    var anchor : AnchorModel?
    
    //Mark:- 自定义构造函数
    init(dict:[NSString : NSObject]) {
        super.init()
        setValuesForKeys(dict as [String : Any])
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
