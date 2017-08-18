//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by admin on 17/8/18.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class AmuseViewModel {

}

extension AmuseViewModel {
    func loadAmuseData(finishedCllback : @escaping () -> ()) {
    NetworkTools.requestData(tape: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
        //1.对结果进行处理
        guard let resultDict = result as? [String : Any] else {  return }
        }
    }
}
