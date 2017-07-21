//
//  NetworkTools.swift
//  DYZB
//
//  Created by admin on 17/7/21.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(tape : MethodType, URLString : String, parameters : [String : NSString]?=nil, finishedCallback : @escaping (_ result : AnyObject) -> ()) {
    
        //1.获取类型
        let method = tape == .GET ? HTTPMethod.get : HTTPMethod.post
        
        //2.发送网络请求
     Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
        
        //3.获取结果
        guard let result = response.result.value else {
            return
        }
        
        //4.结果回调
        finishedCallback(result as AnyObject)
        
        }
    
    }
}
