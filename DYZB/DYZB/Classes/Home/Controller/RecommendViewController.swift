//
//  RecommendViewController.swift
//  DYZB
//
//  Created by admin on 17/7/19.
//  Copyright © 2017年 smartFlash. All rights reserved.
//
/*
 1> 请求0/1数据，并转成模型对象
 2>对数据进行排序
 3>显示headerView的内容
 */

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: UIViewController {

    //Mark:- 懒加载属性
    lazy var recommendVM : RecommendVeiwModel = RecommendVeiwModel()
    lazy var collectionView : UICollectionView = {[unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kItemW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top:0, left: kItemMargin, bottom: kItemMargin,right:kItemMargin)
        
        //创建UICollectionView
        let collcetionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collcetionView.backgroundColor = UIColor.white
        collcetionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collcetionView.dataSource = self
        collcetionView.delegate = self
    collcetionView.register(UINib(nibName:"CollectionNormalCell", bundle:nil), forCellWithReuseIdentifier: "normalCellID")
        
    collcetionView.register(UINib(nibName:"CollectionPrettyCell", bundle:nil), forCellWithReuseIdentifier: "prettyCellID")
    collcetionView.register(UINib(nibName:"CollectionHeaderView", bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collcetionView
        }()
    lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCyleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()
    
    //Mark:- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
}

//Mark:- 设置UI界面内容
extension RecommendViewController{
    func setupUI(){
        //1.将UIcollectionView添加到控制器的view
        view.addSubview(collectionView)
        
        //2.将cycleView添加到collectionView中
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加到collectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//Mark:- 请求数据
extension RecommendViewController{
    func loadData() {
        //1.请求推荐数据
        recommendVM.requestData{
            self.collectionView.reloadData()
        }
        
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
    
}

//Mark:- 遵守UIcollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
    
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]

        //1.定义cell
        let cell : CollectionViewBaseCell! //叹号表示必须有值
        
        //2.取车cell
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prettyCellID", for: indexPath) as! CollectionPrettyCell
        }else{
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalCellID", for: indexPath)
            as! CollectionNormalCell
        }
        
        //3.将模型赋值给cell
        cell.anchor = anchor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerVeiw = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CollectionHeaderView
        //2.取出模型
        headerVeiw.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerVeiw
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    
}

//Mark:- 遵守UIcollectionViewDelegate协议
extension RecommendViewController : UICollectionViewDelegate{

}

