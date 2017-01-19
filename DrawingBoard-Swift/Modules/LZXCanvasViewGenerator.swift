//
//  LZXCanvasViewGenerator.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/8.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

class LZXCanvasViewGenerator: NSObject {
    func canvasBarWithFrame(frame: CGRect) -> LZXCanvasBar {
        return LZXCanvasBar(frame:frame)
    }
}
class StudentCanvasBarGenerator: LZXCanvasViewGenerator {
    override func canvasBarWithFrame(frame: CGRect) -> LZXStudentCanvasBar {
        return LZXStudentCanvasBar(frame:frame)
    }
}

