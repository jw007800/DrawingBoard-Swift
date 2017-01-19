//
//  LZXToolButton.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/8.
//  Copyright © 2017年 songjie. All rights reserved.
//

/*
 1. view 的初始化
 2. 手势的使用
 */
import UIKit

enum LZXTooltype {
    case LZXPen,LZXfluorescencePen,LZXRoundness,LZXRectangle,LZXLine,LZXTextVIew,LZXEraser,LZXScrawlImage
}
class LZXToolButton: UIButton {

    var sizeLabe: UILabel?
    var fontSize: CGFloat = 3.0
    var spacingSize: CGFloat = 0
    var savedColor: UIColor?
    let longPress = UILongPressGestureRecognizer()
    var toolType: LZXTooltype?
    
//    override var isSelected: Bool {
//        didSet {
//            print("ss")
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.showsTouchWhenHighlighted = true
        sizeLabe = UILabel()
        sizeLabe!.frame = CGRect(x: 22,y: 21, width: 15, height: 15)
        sizeLabe!.layer.cornerRadius = 3.0;
        sizeLabe!.textColor = UIColor.orange
        sizeLabe?.font = UIFont.systemFont(ofSize: 11.0)
        sizeLabe!.textAlignment = NSTextAlignment.center
        sizeLabe!.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.addSubview(sizeLabe!)
        
        self.becomeFirstResponder()
        
        longPress.addTarget(self, action: #selector(btnLong(gestureRecognizer:)))
        longPress.minimumPressDuration = 0.5
        self.addGestureRecognizer(longPress)
        
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func btnLong(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            NSLog("手势")
            self.sendObject(object: gestureRecognizer.view)
        }
    }
}
