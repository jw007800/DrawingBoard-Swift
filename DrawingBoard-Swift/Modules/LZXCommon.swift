//
//  LZXCommon.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/8.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

public let kMainScreenWidth = UIScreen.main.bounds.width
public let kMainScreenHeight = UIScreen.main.bounds.height
public let IOS_VERSION = UIDevice.current.systemVersion
//交换元素
public extension Array {
    mutating func exchangeObject(at idx1: Int, withObjectAt idx2: Int) {
        let fistObj = self[idx1]
        self.insert(self[idx2], at: idx1)
        self.remove(at: idx1 + 1)
        self.insert(fistObj, at: idx2)
        self.remove(at: idx2 + 1)
    }
}
class LZXCommon: NSObject {
    

}
