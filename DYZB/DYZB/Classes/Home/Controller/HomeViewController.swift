//
//  HomeViewController.swift
//  DYZB
//
//  Created by admin on 17/7/15.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        
    }
}

//Mark:- 设置UI界面
extension HomeViewController {
     func setupUI() {
        //1.设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //设置左边Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon", highImageName: "", size: CGSize.zero)

        //设置右边Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "home_live_cate_phone", highImageName: "home_header_phone", size: size)
        
          let searchItem = UIBarButtonItem(imageName: "searchIconDark", highImageName: "searchIcon", size: size)

        let qrcodeItem = UIBarButtonItem(imageName: "home_newSaoicon", highImageName: "scanIconHL", size: size)
        
    navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }

}
