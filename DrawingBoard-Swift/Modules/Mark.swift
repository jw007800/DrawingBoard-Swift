//
//  Mark.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/13.
//  Copyright © 2017年 songjie. All rights reserved.
//

import Foundation
import UIKit

public protocol Mark {
    var mark_lineColor: UIColor { get set }
    var mark_lineAlpha: CGFloat { get set }
    var mark_lineWidth: CGFloat { get set }
    var mark_isClear: Bool { get set }
    var mark_location: CGPoint { get set }
    var mark_endPoint: CGPoint { get set }
//    

    func setInitialPoint(_ firstPoint: CGPoint)
    func moveFromPoint(_ startPoint:CGPoint, toPoint endPoint:CGPoint)
    func draw()
}
