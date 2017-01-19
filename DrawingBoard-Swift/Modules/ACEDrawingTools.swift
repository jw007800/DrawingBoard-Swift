//
//  ACEDrawingTools.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/13.
//  Copyright © 2017年 songjie. All rights reserved.
//

import Foundation
import UIKit


struct MIDPoint {
    static func point(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5)
    }
}

class ACEDrawingPenTool: UIBezierPath, Mark {
    
    override init() {
        super.init()
        self.lineCapStyle = CGLineCap.round
        UIColor.red.setStroke()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    //Mark

    var mark_lineColor: UIColor = UIColor.yellow
    
    var mark_lineAlpha: CGFloat = 1.0
    
    var mark_lineWidth: CGFloat = 1.0 {
        didSet{
            print("")
        }
    }
    
    var mark_isClear: Bool = false
    
    var mark_location: CGPoint = CGPoint(x: 0, y: 0)
    
    var mark_endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.move(to: firstPoint)
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.addQuadCurve(to: MIDPoint.point(p1: endPoint, p2: startPoint), controlPoint: startPoint)
    }
    
    func draw() {
        self.lineWidth = self.mark_lineWidth
        if mark_isClear {
            self.stroke(with: CGBlendMode.clear, alpha: 0)
        }else {
            self.mark_lineColor.setStroke()
            self.stroke(with: CGBlendMode.normal, alpha: self.mark_lineAlpha)
        }
    }
}

///////////////// - 画Text - ////////////////

class ACEDrawingMediaTool: Mark {
    
    var firstPoint =  CGPoint()
    
    var lastPoint = CGPoint()
    
    var  mediaArray: [AnyObject] = []
    
    //Mark
    
    var mark_lineColor: UIColor = UIColor.yellow
    
    var mark_lineAlpha: CGFloat = 1.0
    
    var mark_lineWidth: CGFloat = 1.0
    
    var mark_isClear: Bool = false
    
    var mark_location: CGPoint = CGPoint(x: 0, y: 0)
    
    var mark_endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
       
    }
    
    func draw() {
        print(mediaArray)
        for(index, value) in mediaArray.enumerated() {
            print("\(index) ----- \(value)")
        }
    
    }
}


///////////////// - 画矩形 - ////////////////

class ACEDrawingRectangleTool: Mark {
    
    var fill: Bool = false
    
    var firstPoint = CGPoint()
    
    var lastPoint  = CGPoint()
    
    //Mark
    
    var mark_lineColor: UIColor = UIColor.yellow
    
    var mark_lineAlpha: CGFloat = 1.0
    
    var mark_lineWidth: CGFloat = 1.0
    
    var mark_isClear: Bool = false
    
    var mark_location: CGPoint = CGPoint(x: 0, y: 0)
    
    var mark_endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }
    
    func draw() {
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(self.mark_lineAlpha)
        let rectToFill = CGRect(x: self.firstPoint.x, y: self.firstPoint.y, width: self.lastPoint.x - self.firstPoint.x, height: self.lastPoint.y - self.firstPoint.y)
        if self.fill {
            context?.setFillColor(self.mark_lineColor.cgColor)
            context?.fill(rectToFill)
        }else {
            context?.setStrokeColor(self.mark_lineColor.cgColor)
            context?.setLineWidth(self.mark_lineWidth)
            context?.stroke(rectToFill)
        }
    }
}

///////////////// - 画椭圆 - ////////////////

class ACEDrawingEllipseTool: Mark {
    
    var fill: Bool = false
    
    var firstPoint = CGPoint()
    
    var lastPoint  = CGPoint()
    
    //Mark
    
    var mark_lineColor: UIColor = UIColor.yellow
    
    var mark_lineAlpha: CGFloat = 1.0
    
    var mark_lineWidth: CGFloat = 1.0
    
    var mark_isClear: Bool = false
    
    var mark_location: CGPoint = CGPoint(x: 0, y: 0)
    
    var mark_endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }
    
    func draw() {
        let context = UIGraphicsGetCurrentContext()
        context?.setAlpha(self.mark_lineAlpha)
        let rectToFill = CGRect(x: self.firstPoint.x, y: self.firstPoint.y, width: self.lastPoint.x - self.firstPoint.x, height: self.lastPoint.y - self.firstPoint.y)
        if self.fill {
            context?.setFillColor(self.mark_lineColor.cgColor)
            context?.fillEllipse(in: rectToFill)
        }else {
            context?.setStrokeColor(self.mark_lineColor.cgColor)
            context?.setLineWidth(self.mark_lineWidth)
            context?.strokeEllipse(in: rectToFill)
        }
    }
    
}

///////////////// - 画线 - ////////////////

class ACEDrawingLineTool: Mark {
    
    var firstPoint = CGPoint()
    
    var lastPoint  = CGPoint()
    
    //Mark
    
    var mark_lineColor: UIColor = UIColor.yellow
    
    var mark_lineAlpha: CGFloat = 1.0
    
    var mark_lineWidth: CGFloat = 1.0
    
    var mark_isClear: Bool = false
    
    var mark_location: CGPoint = CGPoint(x: 0, y: 0)
    
    var mark_endPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    func setInitialPoint(_ firstPoint: CGPoint) {
        self.firstPoint = firstPoint
    }
    
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint) {
        self.lastPoint = endPoint
    }
    
    func draw() {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.mark_lineColor.cgColor)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(self.mark_lineWidth)
        context?.setAlpha(self.mark_lineAlpha)
        context?.move(to: self.firstPoint)
        context?.addLine(to: self.lastPoint)
        context?.strokePath()
    }
    
}





