//
//  RecommendViewController.swift
//  DYZB
//
//  Created by admin on 17/7/19.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

class RecommendViewController: UIViewController {

    //Mark:- 懒加载属性
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
        
    }
}

//Mark:- 请求数据
extension RecommendViewController{
    func loadData() {
        NetworkTools.requestData(tape: .GET, URLString: "") { (result) in
            
        }
    }
}

//Mark:- 遵守UIcollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义cell
        let cell : UICollectionViewCell
        
        //2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prettyCellID", for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalCellID", for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerVeiw = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        
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

