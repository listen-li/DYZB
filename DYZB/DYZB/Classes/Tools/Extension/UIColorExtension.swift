//
//  UIColorExtension.swift
//  DYZB
//
//  Created by admin on 17/7/17.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

extension UIColor{
   convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b/255.0, alpha: 1.0)
    }
}
