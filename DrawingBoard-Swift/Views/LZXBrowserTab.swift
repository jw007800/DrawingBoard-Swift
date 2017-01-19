//
//  LZXBrowserTab.swift
//  DrawingBoard-Swift
//
//  Created by songjie on 2017/1/9.
//  Copyright © 2017年 songjie. All rights reserved.
//
// lazy 懒加载

import UIKit

class LZXBrowserTab: UIView {
    
    var index: Int = 0
    var reuseIdentifier: String?
    var normalTitleColor: UIColor = UIColor.white
    var selectedTitleColor: UIColor = UIColor.black
    
    let tabNormalImage = UIImage(named:"tab_normal")
    let tabSelectedImage = UIImage(named:"tab_selected")
    
    var titleFont = UIFont.systemFont(ofSize: 14.0)
    
    var selected: Bool? {
        didSet {
            if selected == true {
                self.textLable.textColor = selectedTitleColor
                tapLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
                //获取tap个数
            }else {
                self.textLable.textColor = normalTitleColor
                tapLayer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var tapLayer: CALayer = {
        let tapLayer = CALayer()
        tapLayer.backgroundColor = UIColor.clear.cgColor
        tapLayer.shadowOffset = CGSize(width: 0, height: 2)
        tapLayer.shadowRadius = 5.0
        tapLayer.shadowOpacity = 0.8
        tapLayer.shadowColor = UIColor.black.cgColor
        tapLayer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        tapLayer.borderWidth = 1.0
        tapLayer.masksToBounds = false;
        return tapLayer
    }()
    
    lazy var textLable: UILabel = {
        let textLable = UILabel()
        textLable.backgroundColor = UIColor.clear
        textLable.textAlignment = NSTextAlignment.center
        textLable.font = UIFont.systemFont(ofSize: 14.0)
        return textLable
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.backgroundColor = UIColor.clear
        closeButton.setImage(UIImage(named:"tab_close"), for: UIControlState.normal)
        closeButton.isHidden = true
        closeButton.addTarget(self, action: #selector(closeTap), for: .touchUpInside)
        return closeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        bgImageView.layer.addSublayer(tapLayer)
        self.addSubview(bgImageView)
        self.addSubview(textLable)
        self.addSubview(closeButton)
        
        self.selected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func closeTap() {
        print("closeTap clecked")
        self.superview!.sendObject(object: self)
    }
    
    func prepareForReuse() {
        textLable.text = nil
        index = 0
        selected = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let title = "板书 10"
        let titleSize: CGSize = (title.boundingRect(with: CGSize(width: 150, height: 25), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : titleFont], context: nil).size)
        textLable.frame = CGRect(x: (self.bounds.size.width - titleSize.width)/2, y: (self.bounds.size.height - titleSize.height)/2, width: titleSize.width, height: titleSize.height)
        closeButton.frame = CGRect(x: self.bounds.origin.x + self.bounds.size.width - 26, y: self.bounds.origin.y + 3, width: 25, height: 25)
        bgImageView.frame = self.bounds
        tapLayer.frame = self.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.selected = true
        //代理通知
        let tabIndex = NSNumber.init(value: index)
        self.superview!.sendObject(object: tabIndex)
    }
    
    
}
