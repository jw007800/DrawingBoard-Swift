//
//  ACEDrawingView.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/16.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

enum ACEDrawingTool {
    case pen,media,line,rectangle,ellipse
}

class ACEDrawingView: UIView,UITextViewDelegate {

    var beforPushArray: [Mark] = [Mark]()
    var pathArray     : [Mark] = [Mark]()
    var mediaArray: [AnyObject] = []
    
    var lineColor: UIColor = UIColor.yellow
    var lineWidth: CGFloat = 1.0
    var lineAlpha: CGFloat = 1.0
    var isToCancel: Bool = false //清空
    var isclear: Bool = false {
        didSet {
        }
    }
    var isEraser: Bool = false
    var isNote: Bool = false     //是否为批注
    var currentTool: Mark? = ACEDrawingPenTool() {
        didSet {
            currentTool?.mark_isClear = isclear
            print("有人设置了 currentTool ")
        }
    }
    //默认pen
    var drawTool: ACEDrawingTool = .pen {
        didSet {
            print("有人设置了 drawTool ")
        }
    }
    
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.currentTool = ACEDrawingPenTool()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func exitEditMode() {
        self.updateCacheImage(false)
        self.currentTool = nil
        self.setNeedsDisplay()
        
    }
    
    func updateCacheImage(_ redraw: Bool) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        if redraw {
            self.image = nil
            for tool in self.pathArray{
                tool.draw()
            }
        } else {
            self.image?.draw(at: CGPoint.zero)
            self.currentTool?.draw()
        }
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    //恢复类型
    func restoration() {
        //
    }
    
    //清空
    func clear() {
        self.pathArray.removeAll()
        self.updateCacheImage(true)
        self.currentTool = nil
        self.setNeedsDisplay()
    }
    
    //撤销
    func undoLastSetp() {
        print("ace 撤销")
        if self.pathArray.count != 0 {
            let tool = self.pathArray.last
            self.pathArray.removeLast()
            self.beforPushArray.append(tool!)
            self.updateCacheImage(true)
            self.setNeedsDisplay()
        }
    }
    
    //恢复
    func rodoLastStep() {
        //
    }
    
    func toolWithCurrentSettings() -> Mark {
        switch self.drawTool {
        case .pen:
            let penTool = ACEDrawingPenTool() //笔
            return penTool
        case .media:
            let mediaTool = ACEDrawingMediaTool() //批注或图片
            return mediaTool
        case .line:
            let lineTool = ACEDrawingLineTool()   //线
            return lineTool
        case .rectangle:
            let rectangleTool = ACEDrawingRectangleTool() //矩形
            rectangleTool.fill = false
            return rectangleTool
        case .ellipse:
            let ellipseTool = ACEDrawingEllipseTool() //圆
            ellipseTool.fill = false
            return ellipseTool
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentTool = toolWithCurrentSettings()
        let point = (touches.first?.location(in: self))! as CGPoint
        self.currentTool?.mark_lineWidth = self.lineWidth
        self.currentTool?.mark_lineColor = self.lineColor
        self.currentTool?.mark_lineAlpha = self.lineAlpha
        if self.drawTool == .media && mediaArray.count == 0 {
            //啥也没有默认添加批注
            return
        }
        self.pathArray.append(self.currentTool!)
        self.currentTool?.setInitialPoint(point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point1 = (touches.first?.location(in: self))! as CGPoint
        let point2 = (touches.first?.previousLocation(in: self))! as CGPoint
        self.currentTool?.moveFromPoint(point2, toPoint: point1)
        if self.drawTool == .media {
            self.setNeedsDisplay()
            return
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.exitEditMode()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //
    }
    
    override func draw(_ rect: CGRect) {
        self.image?.draw(in: self.bounds)
        self.currentTool?.draw()
    }

}
