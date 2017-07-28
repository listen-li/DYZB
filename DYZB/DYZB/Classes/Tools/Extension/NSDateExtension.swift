//
//  NSDateExtension.swift
//  DYZB
//
//  Created by admin on 17/7/24.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
    
        //获取当前时间
        let nowDate = NSDate()
        
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
}
