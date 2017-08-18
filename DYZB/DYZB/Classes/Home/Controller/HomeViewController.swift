//
//  HomeViewController.swift
//  DYZB
//
//  Created by admin on 17/7/15.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
     //MARK:- 懒加载属性
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x:0,y:kStatusBarH + kNavigationH,width:kScreenW,height:kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles : titles)
        titleView.delegate = self
        return titleView
        
    }()
    
    lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0,y: kStatusBarH + kNavigationH + kTitleViewH,width: kScreenW,height:contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        for _ in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)),b:CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs,parentViewController:self)
        contentView.delegate = self
        return contentView
    }()
    
    //系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.设置UI界面
        setupUI()
        
    }
}

//Mark:- 设置UI界面
extension HomeViewController {
     func setupUI() {
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

//Mark:- 遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//Mark:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleVeiwProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
