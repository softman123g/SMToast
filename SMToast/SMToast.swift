//
//  SMToast.swift
//
//  Created by softman on 16/1/29.
//  Copyright © 2016年 softman. All rights reserved.
//  一个Toast显示工具
//  A simple Toast notification, like Android Toast. Used Swift.
//
//  1.支持显示多行文本
//  2.支持设置显示时长
//  3.支持距顶部、底部的距离
//  4.支持点击Toast隐藏
//  5.支持屏幕旋转时自动隐藏
//  6.支持回车换行
//  7.静态方法直接调用


import UIKit

class SMToast: NSObject {
    private static let DEFAULT_DURATION = 2.0
    
    class func showText(text:String){
        let toast = SMToast()
        toast.text = text
        toast.showToast()
    }
    class func showText(text:String, duration:Double){
        let toast = SMToast()
        toast.text = text
        toast.duration = duration
        toast.showToast()
    }
    class func showText(text:String, topOffset:CGFloat){
        let toast = SMToast()
        toast.text = text
        toast.topOffset = topOffset
        toast.showToast()
    }
    class func showText(text:String, topOffset:CGFloat, duration:Double){
        let toast = SMToast()
        toast.text = text
        toast.topOffset = topOffset
        toast.duration = duration
        toast.showToast()
    }
    class func showText(text:String, bottomOffset:CGFloat){
        let toast = SMToast()
        toast.text = text
        toast.bottomOffset = bottomOffset
        toast.showToast()
    }
    class func showText(text:String, bottomOffset:CGFloat, duration:Double){
        let toast = SMToast()
        toast.text = text
        toast.bottomOffset = bottomOffset
        toast.duration = duration
        toast.showToast()
    }
    
    private var text:NSString = "" {
        didSet {
            let font = UIFont.boldSystemFontOfSize(14)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .ByWordWrapping
            let attrDict = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
            let expectedRect = text.boundingRectWithSize(CGSizeMake(280,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrDict, context: nil)
            let textSize = expectedRect.size
            
            textLabel.frame = CGRect(x: 0, y: 0, width: textSize.width + 12, height: textSize.height + 12)
            textLabel.backgroundColor = UIColor.clearColor()
            textLabel.textColor = UIColor.whiteColor()
            textLabel.textAlignment = .Center
            textLabel.font = font
            textLabel.text = text as String
            textLabel.numberOfLines = 0
            
            contentView.frame = CGRectMake(0,0,textLabel.frame.size.width, textLabel.frame.size.height)
            contentView.layer.cornerRadius = 5.0
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
            contentView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.75)
            contentView.addSubview(textLabel)
            contentView.autoresizingMask = .FlexibleWidth
            contentView.addTarget(self, action: "toastTapped:", forControlEvents: .TouchDown)
            contentView.alpha = 0.0
            if let _window = UIApplication.sharedApplication().keyWindow {
                contentView.center = _window.center
            }
        }
    }
    private var duration = SMToast.DEFAULT_DURATION
    private var textLabel:UILabel = UILabel()
    private var contentView:UIButton = UIButton()
    private var topOffset:CGFloat = 0 {
        didSet{
            let window = UIApplication.sharedApplication().keyWindow
            if let _window = window {
                contentView.center = CGPointMake(_window.center.x, topOffset + self.contentView.frame.size.height/2)
            }
        }
    }
    private var bottomOffset:CGFloat = 0 {
        didSet {
            let window = UIApplication.sharedApplication().keyWindow
            if let _window = window {
                contentView.center = CGPointMake(_window.center.x, _window.frame.size.height - (bottomOffset + self.contentView.frame.size.height/2))
            }
        }
    }
    
    private override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChanged:", name: UIDeviceOrientationDidChangeNotification, object: UIDevice.currentDevice())
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: UIDevice.currentDevice())
    }

    func deviceOrientationDidChanged(notify: NSNotification){
        self.hideAnimation()
    }
    private func showAnimation(){
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(.EaseIn)
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 1.0
        UIView.commitAnimations()
    }
    func hideAnimation(){//selector不能够是private的
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(.EaseOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("dismissToast")
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 0.0
        UIView.commitAnimations()
    }
    func dismissToast(){
        contentView.removeFromSuperview()
    }
    func toastTapped(sender:UIButton){
        self.hideAnimation()
    }
    
    private func showToast(){
        let window = UIApplication.sharedApplication().keyWindow
        if let _window = window {
            _window.addSubview(contentView)
            self.showAnimation()
            self.performSelector("hideAnimation", withObject: nil, afterDelay: self.duration)
        }
    }
}
