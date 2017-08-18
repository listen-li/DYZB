//
//  GameViewController.swift
//  DYZB
//
//  Created by admin on 17/8/16.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

private let kEdgeMargin :CGFloat = 30
private let kItemW :CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH :CGFloat = kItemW * 6 / 5
private let kHeaderViewH :CGFloat = 50
private let kGameView : CGFloat = 90

class GameViewController: UIViewController {

    //Mark:- 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //创建UIcolletionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName:"CollectionViewGameCell", bundle:nil), forCellWithReuseIdentifier: "kGameCellID")
        collectionView.register(UINib(nibName:"CollectionHeaderView", bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
        }()
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameView), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "dyla_bg_plane_gift")
        headerView.moreBtn.isHidden = true
        headerView.titleLabel.text = "常用"
        return headerView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameView, width: kScreenW, height: kGameView)
        return gameView
    }()
    
    //Mark:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.
        setupUI()
        
        //2.
        loadData()
        
    }
}

//Mark:- 设置UI界面
extension GameViewController{
    fileprivate func setupUI() {
        //1.添加UIcollectionView
        view.addSubview(collectionView)
        
        //2.添加顶部的headerView
        collectionView.addSubview(topHeaderView)
        
        //3.将gameView添加到collectionView
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameView, left: 0, bottom: 0, right: 0)
}
}

//Mark:- 请求数据
extension GameViewController {
    fileprivate func loadData(){
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            
            //2.展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}

//Mark:- 遵守UIcolletionView的数据源代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kGameCellID", for: indexPath) as! CollectionViewGameCell
        //2.
        let gameModel = gameVM.games[indexPath.item]
        cell.baseGame = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId", for: indexPath) as! CollectionHeaderView
        
        //2.给headerView设置属性
        headerView.titleLabel.text = "全部";
        headerView.iconImageView.image = UIImage(named: "dyla_bg_plane_gift")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}

