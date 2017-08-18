//
//  RecommendGameView.swift
//  DYZB
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

    //Mark:- 定义数据的属性
    var groups : [BaseGameModel]? {
        didSet {
       
            //2.刷新表格
            collectionView.reloadData()
        }
    }
    
    
    //Mark:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Mark:- 系统函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        //注册cell
    collectionView.register(UINib(nibName:"CollectionViewGameCell", bundle:nil), forCellWithReuseIdentifier: "kGameCellID")
        
        //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }

}

//Mark:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//Mark:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kGameCellID", for: indexPath) as! CollectionViewGameCell
         cell.baseGame = groups![indexPath.item]
        
        return cell
    }

}
