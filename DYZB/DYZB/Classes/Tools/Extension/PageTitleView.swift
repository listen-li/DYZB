//
//  PageTitleView.swift
//  DYZB
//
//  Created by admin on 17/7/17.
//  Copyright © 2017年 smartFlash. All rights reserved.
//

import UIKit

//Mark:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

//Mark:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat, CGFloat,CGFloat) = (255,120,0)

class PageTitleView: UIView {

    //MARK:- 自定义属性
    var titles : [String]
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    //MARK:- 自定义构造函数
    init(frame : CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //1.设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension PageTitleView{
     func setupUI(){
         //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setupTitleLabel()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabel(){
        //3.确定label一些的frame的值
        let labelW :CGFloat = frame.width / CGFloat(titles.count)
        let labelH :CGFloat = frame.height - kScrollLineH
        let labelY :CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //1.创建UIlabel
            let label = UILabel()
            
            //2.设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r:kNormalColor.0 , g:kNormalColor.1 , b:kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX :CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y:labelY , width: labelW, height:labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self,action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    
    }
    
    private func setupBottomLineAndScrollLine(){
         //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r:kSelectColor.0 , g:kSelectColor.1 , b:kSelectColor.2)
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y:frame.height - kScrollLineH , width: firstLabel.frame.width, height:kScrollLineH)
    }
}

//Mark:- 监听label的点击
extension PageTitleView{
    @objc func titleLabelClick(tapGes:UITapGestureRecognizer){
        //获取目前label的下标志
       guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r:kSelectColor.0 , g:kSelectColor.1 , b:kSelectColor.2)

        oldLabel.textColor = UIColor(r:kNormalColor.0 , g:kNormalColor.1 , b:kNormalColor.2)

        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//Mark:- 对外暴露的方法
extension PageTitleView{
    func setTitleVeiwProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelte = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
       
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r:kSelectColor.0 - colorDelte.0 * progress, g:kSelectColor.1 - colorDelte.1 * progress, b:kSelectColor.2 - colorDelte.2 * progress)

        //3.2变化targetLabel
        targetLabel.textColor = UIColor(r:kNormalColor.0 + colorDelte.0 * progress, g:kNormalColor.1 + colorDelte.1 * progress, b:kNormalColor.2 + colorDelte.2 * progress)
        
        //4.记录最新的Index
        currentIndex = targetIndex

    }
}
