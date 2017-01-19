//
//  LZXPathCommand.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//
// 不进则退

import UIKit

struct pathCommand {
    static func execute(_ redo: Bool){
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        let rootController = myAppdelegate.window?.rootViewController as! LZXDoodleViewController
        if redo {
            rootController.doodleview?.undoLastSetp()
        } else {
            rootController.doodleview?.rodoLastStep()
        }
    }
}
class LZXRedoCommand: LZXBarCommand {
    override func execute() {
        NSLog("LZXRedoCommand 执行")
        pathCommand.execute(false)
    }
}
class LZXUndoCommand: LZXBarCommand {
    override func execute() {
        NSLog("LZXUndoCommand 执行")
        pathCommand.execute(true)
    }
}
