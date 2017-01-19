//
//  LZXCommandBtn.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

class LZXCommandBtn: UIButton {
    
    var command: LZXBarCommand? {
        didSet {
            NSLog("设置了--LZXCommandBtn")
        }
    }

}
