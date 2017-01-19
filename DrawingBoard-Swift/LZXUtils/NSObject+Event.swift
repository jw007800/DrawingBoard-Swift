//
//  NSObject+Event.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//

import Foundation
/*  知识点
 1. 闭包作为一个变量 var 闭包名称:(参数类型)
 */
extension NSObject {
    struct RuntimeKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "ZXObjectSingleObjectEvent".hashValue)
        /// ...其他Key声明
    }
    public func receiveObject(sendObject: (_:Any?) -> Void) { 
        objc_setAssociatedObject(self, RuntimeKey.jkKey, sendObject, .OBJC_ASSOCIATION_RETAIN)
    }
    func sendObject(object:Any?) {
        //objc_getAssociatedObject(self, RuntimeKey.jkKey)
        var block:(_ object:(_:Any?)) -> Void
        block = objc_getAssociatedObject(self, RuntimeKey.jkKey) as! ((Any?)) -> Void
        block(object)
    }
    

}
