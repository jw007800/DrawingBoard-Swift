//
//  LZXCanvasBar.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/8.
//  Copyright © 2017年 songjie. All rights reserved.
//

import UIKit

class LZXCanvasBar: UIImageView {
    
    var toosButtons:[LZXToolButton] = [LZXToolButton]()
    let btnMargin: CGFloat = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.red
        self.isUserInteractionEnabled = true
        self.contentMode = UIViewContentMode.scaleToFill
        image = UIImage(named: "dooletop_bg")
        
        let vgView = UIView();
        vgView.frame = CGRect(x: 0, y: 0, width: 295, height: 40)
        vgView.center = CGPoint(x: (self.frame.origin.x + self.frame.size.width)/2, y: (self.frame.origin.y + self.frame.size.height)/2)
        vgView.backgroundColor = UIColor.clear
        vgView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        vgView.layer.cornerRadius = 5.0
        self.addSubview(vgView)
        // 钢笔
        let penButton = LZXToolButton()
        penButton.toolType = .LZXPen
        penButton.frame = CGRect(x: 2, y: 2, width: 38, height: 38)
        penButton.fontSize = 1.0
        penButton.spacingSize = 1
        penButton.savedColor = UIColor.yellow
        let s = String(format: "%.f",penButton.fontSize)
        let message = "\(s)"
        penButton.sizeLabe?.text = message
        penButton.setImage(UIImage(named:"钢笔-ina"),for:.normal)
        penButton.setImage(UIImage(named:"钢笔-a"),for:.selected)
        penButton.receiveObject { (object) in
            NSLog("penButton clecked 弹出选择 pop ")
        }
        penButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(penButton)
        penButton.isSelected = true
        vgView.addSubview(penButton)
        //银光笔
        let fluorescencePenButton = LZXToolButton()
        fluorescencePenButton.toolType = .LZXfluorescencePen
        fluorescencePenButton.frame = CGRect(x: penButton.frame.size.width + penButton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        fluorescencePenButton.fontSize = 18.0
        fluorescencePenButton.spacingSize = 0.3
        fluorescencePenButton.savedColor = UIColor.yellow
        fluorescencePenButton.sizeLabe?.text = String(format: "%.f",fluorescencePenButton.fontSize)
        fluorescencePenButton.setImage(UIImage(named:"笔-ina"),for:.normal)
        fluorescencePenButton.setImage(UIImage(named:"笔-a"),for:.selected)
        fluorescencePenButton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        fluorescencePenButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(fluorescencePenButton)
        vgView.addSubview(fluorescencePenButton)
        //圆
        let roundnessBotton = LZXToolButton()
        roundnessBotton.toolType = .LZXRoundness
        roundnessBotton.frame = CGRect(x: fluorescencePenButton.frame.size.width + fluorescencePenButton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        roundnessBotton.fontSize = 3.0
        roundnessBotton.spacingSize = 1
        roundnessBotton.savedColor = UIColor.yellow
        roundnessBotton.sizeLabe?.text = String(format: "%.f",roundnessBotton.fontSize)
        roundnessBotton.setImage(UIImage(named:"圆-ina"),for:.normal)
        roundnessBotton.setImage(UIImage(named:"圆-a"),for:.selected)
        roundnessBotton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        roundnessBotton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(roundnessBotton)
        vgView.addSubview(roundnessBotton)
        //矩形
        let rectangleButton = LZXToolButton()
        rectangleButton.toolType = .LZXRectangle
        rectangleButton.frame = CGRect(x: roundnessBotton.frame.size.width + roundnessBotton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        rectangleButton.fontSize = 3.0
        rectangleButton.spacingSize = 1
        rectangleButton.savedColor = UIColor.yellow
        rectangleButton.sizeLabe?.text = String(format: "%.f",rectangleButton.fontSize)
        rectangleButton.setImage(UIImage(named:"框-ina"),for:.normal)
        rectangleButton.setImage(UIImage(named:"框-a"),for:.selected)
        rectangleButton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        rectangleButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(rectangleButton)
        vgView.addSubview(rectangleButton)
        //线
        let lineButton = LZXToolButton()
        lineButton.toolType = .LZXLine
        lineButton.frame = CGRect(x: rectangleButton.frame.size.width + rectangleButton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        lineButton.fontSize = 3.0
        lineButton.spacingSize = 1
        lineButton.savedColor = UIColor.yellow
        lineButton.sizeLabe?.text = String(format: "%.f",lineButton.fontSize)
        lineButton.setImage(UIImage(named:"线-ina"),for:.normal)
        lineButton.setImage(UIImage(named:"线-a"),for:.selected)
        lineButton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        lineButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(lineButton)
        vgView.addSubview(lineButton)
        //批注
        let noteButton = LZXToolButton()
        noteButton.toolType = .LZXTextVIew
        noteButton.frame = CGRect(x: lineButton.frame.size.width + lineButton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        noteButton.fontSize = 18.0
        noteButton.spacingSize = 1
        noteButton.savedColor = UIColor.yellow
        noteButton.sizeLabe?.text = String(format: "%.f",noteButton.fontSize)
        noteButton.setImage(UIImage(named:"字-ina"),for:.normal)
        noteButton.setImage(UIImage(named:"字-a"),for:.selected)
        noteButton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        noteButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(noteButton)
        vgView.addSubview(noteButton)
        //橡皮
        let eraserButton = LZXToolButton()
        eraserButton.toolType = .LZXEraser
        eraserButton.frame = CGRect(x: noteButton.frame.size.width + noteButton.frame.origin.x + btnMargin, y: 2, width: 38, height: 38)
        eraserButton.fontSize = 20.0
        eraserButton.savedColor = UIColor.clear
        eraserButton.sizeLabe?.isHidden = true
        eraserButton.setImage(UIImage(named:"橡皮-ina"),for:.normal)
        eraserButton.setImage(UIImage(named:"橡皮-a"),for:.selected)
        eraserButton.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        eraserButton.addTarget(self, action: #selector(verifyTypeWithBtn(sender:)), for: .touchUpInside)
        toosButtons.append(eraserButton)
        vgView.addSubview(eraserButton)
        //切换背景
        let changeBtn = LZXCommandBtn()
        changeBtn.frame = CGRect(x: vgView.frame.origin.x + vgView.frame.size.width + 80, y: vgView.frame.origin.y, width: 40, height: 40)
        changeBtn.showsTouchWhenHighlighted = true;
        changeBtn.setImage(UIImage(named:"切换背景"),for:.normal)
        changeBtn.receiveObject { (object) in
            NSLog("penButton clecked")
        }
        changeBtn.command = ChangeBackgroundImageCommand()
        changeBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        self.addSubview(changeBtn)
        //删除
        let deleateBtn = LZXCommandBtn()
        deleateBtn.frame = CGRect(x: 250, y: vgView.frame.origin.y, width: 40, height: 40)
        deleateBtn.setImage(UIImage(named:"删除"),for:.normal)
        deleateBtn.receiveObject { (object) in
            NSLog("deleateBtn clecked")
        }
        deleateBtn.command = LZXDeleteScribbleCommand()
        deleateBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        self.addSubview(deleateBtn)
        //撤销
        let undoBtn = LZXCommandBtn()
        undoBtn.frame = CGRect(x: 350, y: vgView.frame.origin.y, width: 40, height: 40)
        undoBtn.setImage(UIImage(named:"撤消"),for:.normal)
        undoBtn.receiveObject { (object) in
            NSLog("undoBtn clecked")
        }
        undoBtn.command = LZXUndoCommand()
        undoBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        self.addSubview(undoBtn)


        
    }
    //切换工具
    func verifyTypeWithBtn(sender barBtn: LZXToolButton) {
        barBtn.isSelected = !barBtn.isSelected;
        self.sendObject(object: barBtn)
        for (_, value) in self.toosButtons.enumerated() {
            if value != barBtn {
                 value.isSelected = false
            }
        }
    }
    
    func buttonClick(sender otherButton: LZXCommandBtn) {
        self.sendObject(object: otherButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
