//
//  MainViewController.swift
//  DYZB
//
//  Created by admin on 17/7/15.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
    }
    
    private func addChildVc(storyName : String){
        
        //通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle:nil).instantiateInitialViewController()!
        //通过childVc作为子控制器
        addChildViewController(childVc)
    }

}
