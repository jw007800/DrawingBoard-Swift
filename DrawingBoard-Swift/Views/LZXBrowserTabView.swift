//
//  LZXBrowserTabView.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

//限制此协议只能呗类类型遵循
@objc protocol LZXBrowserTabViewDelegate: class {
    func browserTableView(_ browserTabView: LZXBrowserTabView, didSelecedAtIndex index: Int)
    @objc optional func browserTableView(_ browserTabView: LZXBrowserTabView, willRemoveTabAtIndex index: Int)
    func browserTableView(_ browserTabView: LZXBrowserTabView, didRemoveTabAtIndex index: Int)
    //拖到改变顺序
    func browserTableView(_ browserTabView: LZXBrowserTabView, exchangeTabAtIndex fromIndex: Int, withTabAtIndex index: Int)
    
}
class LZXBrowserTabView: UIView {

    var titles: [String] = [String]()
    
    var tabSubViews: [LZXBrowserTab] = [LZXBrowserTab]()
    var dooleViews: [UIView] = [UIView]()
    var page: Int = 1
    var seletedTabIndex: Int = 0
    
    var addButton: UIButton = {
        let addButton = UIButton()
        addButton.backgroundColor = UIColor.clear
        addButton.setImage(UIImage(named:"tab_new_add"), for: UIControlState.normal)
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        return addButton
        
    }()
    
    var delegate: LZXBrowserTabViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(patternImage: UIImage(named:"dooletop_bg")!)
        self.addSubview(addButton)
        self.receiveObject { (object) in
            if object is NSNumber {
                let numberObj = object as! NSNumber
                let index = numberObj.intValue
                currentSelected(numberObj: index)
            }
            if object is LZXBrowserTab {
                let tab = object as! LZXBrowserTab
                removeTab(at: tab.index)
            }
            self.caculateFrame()
        }
    }
    //便利构造器,注：便利构造器里面需要调用指定构造器
    //, delegate: LZXBrowserTabViewDelegate
    convenience init(titles:[String], contentViews:[UIView]) {
        self.init()
        self.titles = titles
        self.dooleViews = contentViews
        for i in 0 ..< titles.count {
            let tab = LZXBrowserTab()
            let panGuesture = UIPanGestureRecognizer()
            panGuesture.addTarget(self, action: #selector(handlePanGuesture(gestureRecognizer:)))
            tab.addGestureRecognizer(panGuesture)
            tab.textLable.text = String(format: "板书 %d",(i + 1))
            tab.index = i
            tabSubViews.append(tab)
            self.addSubview(tab)
        }
        self.caculateFrame()
    }
    
    public func addTabWithTitle(_ title: String) {
        let count: CGFloat = CGFloat(tabSubViews.count)
        let TAB_WIDTH =  (kMainScreenWidth - 135.0 )/count
        if TAB_WIDTH * count > self.bounds.size.width {
            return
        }
        let tab = LZXBrowserTab()
        self.addSubview(tab)
        let dooleView = LZXDooleView()
        let panGuesture = UIPanGestureRecognizer()
        panGuesture.addTarget(self, action: #selector(handlePanGuesture(gestureRecognizer:)))
        tab.addGestureRecognizer(panGuesture)
        page += 1
        tab.textLable.text = String(format: "板书 %d",page)
        tabSubViews.append(tab)
        self.dooleViews.append(dooleView)
        for i in 0 ..< tabSubViews.count {
            let tab = tabSubViews[i]
            tab.index = i
            tab.closeButton.isHidden = true
            tab.selected = false
            //test.....
            switch i {
            case 0:
                dooleView.backgroundColor = UIColor.orange
            case 1:
                dooleView.backgroundColor = UIColor.red
            case 2:
                dooleView.backgroundColor = UIColor.blue
            default: break
                //
            }
        }
        seletedTabIndex = tabSubViews.count - 1
        tab.closeButton.isHidden = false
        tab.selected = true
        
        self.caculateFrame()
        
        delegate?.browserTableView(self, didSelecedAtIndex: seletedTabIndex)
    
    }
      
    private func currentSelected(numberObj index: Int) {
        for i in 0 ..< tabSubViews.count {
            let tab = tabSubViews[i]
            tab.index = i
            tab.closeButton.isHidden = true
            tab.selected = false
        }
        seletedTabIndex = index
        let tab = tabSubViews[index]
        tab.closeButton.isHidden = false
        tab.selected = tabSubViews.count == 1 ?  false : true
        
        delegate?.browserTableView(self, didSelecedAtIndex: seletedTabIndex)
    }
    
    private func removeTab(at index: Int) {
        if tabSubViews.count == 1 {
            return
        }
        let currentTab = tabSubViews[index]
        currentTab.removeFromSuperview()
        tabSubViews.remove(at: index)
        for i in 0 ..< tabSubViews.count {
            let tab = tabSubViews[i]
            tab.index = i
            tab.closeButton.isHidden = true
            tab.selected = false
        }
        let lastTab = tabSubViews.last
        lastTab?.closeButton.isHidden = false
        lastTab?.selected = tabSubViews.count == 1 ?  false : true
        delegate?.browserTableView(self, didRemoveTabAtIndex: index)
        self.currentSelected(numberObj: (index - 1))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func caculateFrame() {
        var right: CGFloat = 0
        let count: CGFloat = CGFloat(tabSubViews.count)
        let TAB_WIDTH =  (kMainScreenWidth - 135.0 )/count
        for i in 0 ..< tabSubViews.count {
            let tabFrame = CGRect(x: right, y: 0, width: TAB_WIDTH, height: 30)
            let tab = tabSubViews[i]
            tab.frame = tabFrame
            right += TAB_WIDTH
        }
    }
    
    func add() {
        print("add")
        let tapTitle = String(format: "板书 %d",tabSubViews.count + 1)
        if tabSubViews.count >= 10 {
            return
        }
        self.addTabWithTitle(tapTitle)
    }
    
    override func layoutSubviews() {
        addButton.frame = CGRect(x: self.frame.size.width - 32, y: 1, width: 30, height: 30)
    }
   
    func handlePanGuesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let panTab = gestureRecognizer.view as! LZXBrowserTab
        let panPosition: Int = self.tabSubViews.index(of: panTab)!
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            self.currentSelected(numberObj: panPosition)
        }else if gestureRecognizer.state == UIGestureRecognizerState.changed {
            let count: CGFloat = CGFloat(tabSubViews.count)
            let TAB_WIDTH =  (kMainScreenWidth - 135.0 )/count
            let position = gestureRecognizer.translation(in: self)
            let center = CGPoint(x: (gestureRecognizer.view?.center.x)! + position.x, y: (gestureRecognizer.view?.center.y)!)
            if(center.x < (self.bounds.size.width - 5) && center.x > 5) {
                gestureRecognizer.view?.center = center
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                let moved = abs(CGFloat(center.x) - (CGFloat(TAB_WIDTH) * CGFloat(panPosition)) - CGFloat(TAB_WIDTH/2.0))
                if moved > CGFloat(TAB_WIDTH/2.0) {
                    let nextPos = position.x > 0 ? panPosition + 1 : panPosition - 1
                    if nextPos >= tabSubViews.count {
                        return
                    }
                    let nextTab = tabSubViews[nextPos]
//                    //Array 没有了元素替换方法，所以扩展了一个
                    tabSubViews.exchangeObject(at: panPosition, withObjectAt: nextPos)
                    for i in 0 ..< tabSubViews.count {
                        let tab = tabSubViews[i]
                        tab.index = i
                        tab.selected = false
                        if i == seletedTabIndex {
                            tab.selected = true
                        }
                    }
                    UIView.animate(withDuration: 0.3, animations: {
                        nextTab.frame = CGRect(x: (Int(TAB_WIDTH) * panPosition) + 5, y: 0, width: Int(TAB_WIDTH), height: Int(self.bounds.size.height))
                        self.delegate?.browserTableView(self, exchangeTabAtIndex: panPosition, withTabAtIndex: nextPos)
                    })
                }
            }

        }else if gestureRecognizer.state == UIGestureRecognizerState.ended {
            UIView.animate(withDuration: 0.3, animations: {
                panTab.center = CGPoint(x: panTab.center.x, y: panTab.center.y)
                self.currentSelected(numberObj: panPosition)
                self.caculateFrame()
                
            })
        }
    }

}
