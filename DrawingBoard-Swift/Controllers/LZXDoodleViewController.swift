//
//  LZXDoodleViewController.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/8.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

extension LZXDoodleViewController: LZXBrowserTabViewDelegate {
    internal func browserTableView(_ browserTabView: LZXBrowserTabView, didSelecedAtIndex index: Int) {
        print("didSelecedAtIndex \(index)")
        totalLable.text = "of  " + String(tabController.tabSubViews.count)
        currentLable.text = "\(index + 1)"
        if (doodleview != nil) {
            doodleview?.removeFromSuperview()
        }
        self.doodleview = browserTabView.dooleViews[index] as? LZXDooleView
        self.view.addSubview(self.doodleview!)
        self.view.sendSubview(toBack: self.doodleview!)
        
    }
    internal func browserTableView(_ browserTabView: LZXBrowserTabView, didRemoveTabAtIndex index: Int) {
        print("didRemoveTabAtIndex \(index)")
        totalLable.text = "of  " + String(tabController.tabSubViews.count)
        currentLable.text = "\(index)"
        browserTabView.dooleViews.remove(at: index)
    }
    internal func browserTableView(_ browserTabView: LZXBrowserTabView, exchangeTabAtIndex fromIndex: Int, withTabAtIndex index: Int) {
        print("exchangeTabAtIndex fromIndex: \(fromIndex) withTabAtIndex: \(index)")
        browserTabView.dooleViews.exchangeObject(at: fromIndex, withObjectAt: index)
    }
}

class LZXDoodleViewController: UIViewController {
    
    var canvasBar: LZXCanvasBar?
    var customBtn: LZXCommandBtn?
    var toolBtn:   LZXToolButton?
    var tabViewDelegate: LZXBrowserTabViewDelegate?
    var isOpen: Bool = false
    var doodleview: LZXDooleView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.loadCanvasBarWithGenerator(generator: StudentCanvasBarGenerator())
        self.view.addSubview(tabController)
        tabController.backgroundColor = UIColor.red
        tabController.frame = CGRect(x: 0, y: (self.canvasBar?.frame.origin.y)! + (self.canvasBar?.frame.size.height)! - 30, width: kMainScreenWidth, height: 30)
        tabController.delegate = self
        self.doodleview = tabController.dooleViews[0] as? LZXDooleView
        self.view.addSubview(self.doodleview!)
        self.view.sendSubview(toBack: tabController)
        self.view.addSubview(expandButton)
        expandButton.addSubview(currentLable)
        expandButton.addSubview(line)
        expandButton.addSubview(totalLable)
        totalLable.text = "of  " + String(tabController.tabSubViews.count)
    }
    
    lazy var tabController: LZXBrowserTabView = {
        let tabController = LZXBrowserTabView(titles:["板书 1"], contentViews:[LZXDooleView()])
        return tabController
    }()
    
    lazy var expandButton: UIButton = {
        let expandButton = UIButton()
        let image = UIImage(named:"下拉")
        expandButton.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        expandButton.setImage(image,for:.normal)
        expandButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        expandButton.center = CGPoint(x:((self.canvasBar?.frame.origin.x)! + (self.canvasBar?.frame.size.width)!)/2 ,y: (image?.size.height)!/2 + (self.canvasBar?.frame.size.height)!)
        return expandButton
    }()
    
    lazy var currentLable: UILabel = {
        let currentLable = UILabel()
        currentLable.backgroundColor = UIColor.clear
        currentLable.shadowColor = UIColor.black.withAlphaComponent(0.5)
        currentLable.shadowOffset = CGSize(width: 1, height: 1);
        currentLable.textColor = UIColor.white
        currentLable.textAlignment = NSTextAlignment.center
        currentLable.font = UIFont.systemFont(ofSize: 11.0)
        currentLable.text = "1"
        currentLable.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        return currentLable
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.layer.cornerRadius = 2.0;
        line.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor;
        line.layer.shadowOffset = CGSize(width: 1, height: 1);
        line.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        line.frame = CGRect(x: 46, y: 4, width: 1, height: 12)
        return line
    }()
    
    lazy var totalLable: UILabel = {
        let totalLable = UILabel()
        totalLable.backgroundColor = UIColor.clear
        totalLable.textColor = UIColor.white
        totalLable.shadowColor = UIColor.black.withAlphaComponent(0.5)
        totalLable.shadowOffset = CGSize(width: 1, height: 1);
        totalLable.textAlignment = NSTextAlignment.center
        totalLable.font = UIFont.systemFont(ofSize: 11.0)
        totalLable.frame = CGRect(x: 50, y: 0, width: 25, height: 20)
        return totalLable
    }()
    
    func buttonClick(sender otherButton: UIButton) {
        UIView.animate(withDuration: 0.25) {
            let image = UIImage(named:"下拉")
            if self.isOpen == false {
                self.tabController.frame = CGRect(x: 0,
                                                  y:self.tabController.frame.origin.y + 30,
                                                  width: self.tabController.frame.size.width,
                                                  height: self.tabController.frame.size.height)
                self.expandButton.center = CGPoint(x:((self.canvasBar?.frame.origin.x)! + (self.canvasBar?.frame.size.width)!)/2 ,
                                                   y: (image?.size.height)!/2 + (self.canvasBar?.frame.size.height)! + self.tabController.frame.size.height)
                self.isOpen = true
            }else {
                self.tabController.frame = CGRect(x: 0,
                                                  y:self.tabController.frame.origin.y - 30,
                                                  width: self.tabController.frame.size.width,
                                                  height: self.tabController.frame.size.height)
                self.expandButton.center = CGPoint(x:((self.canvasBar?.frame.origin.x)! + (self.canvasBar?.frame.size.width)!)/2 ,
                                                   y: (image?.size.height)!/2 + (self.canvasBar?.frame.size.height)!)
                self.isOpen = false
            }
            self.view.sendSubview(toBack: self.tabController.dooleViews[0])
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCanvasBarWithGenerator(generator: LZXCanvasViewGenerator) {
        let canvasBarRect = CGRect(x: 0, y: 0, width: kMainScreenWidth, height: 50)
        canvasBar = generator .canvasBarWithFrame(frame: canvasBarRect)
        canvasBar?.receiveObject(sendObject: { (object) in
            if object is LZXToolButton {
                self.toolBtn = object as! LZXToolButton?
                LZXCoordinatingManager.sharedInstance.canvasViewController = self
                self.doodleview?.lineWidth = (self.toolBtn?.fontSize)!
                self.doodleview?.lineAlpha = (self.toolBtn?.spacingSize)!
                self.doodleview?.lineColor = (self.toolBtn?.savedColor)!
                ((self.toolBtn?.toolType)! == .LZXEraser) ? (self.doodleview?.isclear = true) : (self.doodleview?.isclear = false)
                
                self.doodleview?.drawTool = self.currentDrawTool((self.toolBtn?.toolType)!)
            }
            if object is LZXCommandBtn {
                self.customBtn = object as! LZXCommandBtn?
                self.customBtn?.command?.execute()
                LZXCoordinatingManager.sharedInstance.canvasViewController = self
            }
        })
        self.view.addSubview(canvasBar!)
    }
    
    func currentDrawTool(_ toolType: LZXTooltype) -> ACEDrawingTool {
        switch toolType {
        case .LZXPen:
            return ACEDrawingTool.pen
        case .LZXfluorescencePen:
            return ACEDrawingTool.pen
        case .LZXRoundness:
            return ACEDrawingTool.ellipse
        case .LZXRectangle:
            return ACEDrawingTool.rectangle
        case .LZXLine:
            return ACEDrawingTool.line
        case .LZXTextVIew:
            return ACEDrawingTool.media
        case .LZXEraser:
            return ACEDrawingTool.pen
        case .LZXScrawlImage:
            return ACEDrawingTool.media
        }
    }
}
