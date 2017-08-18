//
//  RecommendVeiwModel.swift
//  DYZB
//
//  Created by admin on 17/7/21.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class RecommendVeiwModel {
      //Mark:- 懒加载属性
    //0 1 2-12
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
    lazy var cycleModels : [CycleModel] = [CycleModel]()
}

//Mark:- 发送网络请求
extension RecommendVeiwModel{
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {
        //0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
   
        //创建Group
        let disgroup = DispatchGroup()
        
        //1.请求第一部分推荐数据
        disgroup.enter()
        NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
          
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历字典，并将字典转成模型对象
            //3.1设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3离开组
            disgroup.leave()
            
        }
        
        //2.请求第二部分颜值数据
        disgroup.enter()
        NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
          
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历字典，并将字典转成模型对象
            //3.1设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.3离开组
            disgroup.leave()
            
        }
        
        //3.请求2-12部分游戏数据
        disgroup.enter()
        NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //3.4离开组
            disgroup.leave()
           
        }
        
        //4.所有的数据都请求到，之后进行排序
        disgroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }
    
    //请求无限轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            //1.获取整体字典数据
            guard let resultDic = result as? [NSString : NSObject] else { return }
            
            //2.根据data的key获取数据
            guard let dataArray = resultDic["data"] as? [[NSString : NSObject]] else { return }
            
            //3.字典转模型对象
            for dict in dataArray {
           self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}
