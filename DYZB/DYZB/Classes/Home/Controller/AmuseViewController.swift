//
//  AmuseViewController.swift
//  DYZB
//
//  Created by admin on 17/8/18.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class AmuseViewController: UIViewController {

    //懒加载属性
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

    
    
    //系统函数调用
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
    }
}


//Mark:- 设置UI界面
extension AmuseViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

//Mark:- 遵守UIcollectionView的数据源协议
extension AmuseViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //return recommendVM.anchorGroups.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let group = recommendVM.anchorGroups[section]
//        
//        return group.anchors.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //0.取出模型对象
        //let group = recommendVM.anchorGroups[indexPath.section]
        //let anchor = group.anchors[indexPath.item]
        
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
      //  cell.anchor = anchor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerVeiw = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CollectionHeaderView
        //2.取出模型
      //  headerVeiw.group = recommendVM.anchorGroups[indexPath.section]
        
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
extension AmuseViewController : UICollectionViewDelegate{
    
}
