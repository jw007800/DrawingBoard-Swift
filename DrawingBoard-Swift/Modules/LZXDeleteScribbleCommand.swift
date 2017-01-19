//
//  LZXDeleteScribbleCommand.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

class LZXDeleteScribbleCommand: LZXBarCommand {
    override func execute() {
        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
        let rootController = myAppdelegate.window?.rootViewController as! LZXDoodleViewController
        rootController.doodleview?.clear()
    }
}
