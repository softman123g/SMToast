//
//  SMToast.swift
//  TakePictureAndRecordVideo
//
//  Created by softman on 16/1/29.
//  Copyright © 2016年 softman. All rights reserved.
//  一个Toast显示工具


import UIKit

class SMToast: NSObject {
    private static let DEFAULT_DURATION = 2.0
    private var text:NSString = ""
    private var duration = 2.0
    private var contentView:UIButton!
    
    class func showText(text:String, duration:Double){
        let toast = SMToast(text: text, duration: duration)
        toast.showToast()
    }
    class func showText(text:String){
        let toast = SMToast(text: text, duration: DEFAULT_DURATION)
        toast.showToast()
    }
    private override init() {
        super.init()
    }

    private init(text:NSString, duration:Double) {
        super.init()
        self.text = text
        self.duration = duration
        let font = UIFont.boldSystemFontOfSize(14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping
        let attrDict = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        let expectedRect = text.boundingRectWithSize(CGSizeMake(280,CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrDict, context: nil)
        let textSize = expectedRect.size
        let textLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: textSize.width + 12, height: textSize.height + 12))
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = .Center
        textLabel.font = font
        textLabel.text = text as String
        textLabel.numberOfLines = 0
        
        contentView = UIButton(frame: CGRectMake(0,0,textLabel.frame.size.width, textLabel.frame.size.height))
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        contentView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.75)
        contentView.addSubview(textLabel)
        contentView.autoresizingMask = .FlexibleWidth
        contentView.addTarget(self, action: "toastTapped:", forControlEvents: .TouchDown)
        contentView.alpha = 0.0
    }
    private func showAnimation(){
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(.EaseIn)
        UIView.setAnimationDuration(0.3)
        contentView?.alpha = 1.0
        UIView.commitAnimations()
    }
    func hideAnimation(){//selector不能够是private的
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(.EaseOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStopSelector("dismissToast")
        UIView.setAnimationDuration(0.3)
        contentView?.alpha = 1.0
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
            contentView.center = _window.center
            window?.addSubview(contentView)
            self.showAnimation()
            self.performSelector("hideAnimation", withObject: nil, afterDelay: self.duration)
        }
    }
}
