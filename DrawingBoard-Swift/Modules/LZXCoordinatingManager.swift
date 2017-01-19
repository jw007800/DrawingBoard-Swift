//
//  LZXCoordinatingManager.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

final class LZXCoordinatingManager: NSObject {
    //内部声明静态常量
    static let sharedInstance = LZXCoordinatingManager()
    var canvasViewController: LZXDoodleViewController? {
        didSet {
            NSLog("赋值成功")
        }
    }
    //私有化构造器方法
    private override init() {
        NSLog("初始化了一次")
         self.canvasViewController  = LZXDoodleViewController()
        
    }
}
