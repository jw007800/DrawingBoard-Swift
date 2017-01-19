//
//  LZXDooleView.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/10.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

class LZXDooleView: ACEDrawingView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init() {
        super.init(frame: CGRect(x: 0, y: 50, width: kMainScreenWidth, height:kMainScreenHeight - 50))
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
