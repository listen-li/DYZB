//
//  GameViewModel.swift
//  DYZB
//
//  Created by admin on 17/8/16.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class GameViewModel {

    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            
            //1.获取到数据
            guard let resultDit = result as? [String : Any] else { return }
            guard let dataArray = resultDit["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict : dict))
            }
            //3.完成回调
            finishedCallback()
        }
    }
}
