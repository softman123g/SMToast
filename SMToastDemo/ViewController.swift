//
//  ViewController.swift
//  SMToastDemo
//
//  Created by softman on 16/2/23.
//  Copyright © 2016年 softman123g. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.frame = CGRectMake(50, 120, 150, 50)
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Show Demo Text", forState: .Normal)
        button.addTarget(self, action: "showDemo:", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showDemo(sender:UIButton) {
        sender.alpha = 0.0
//        SMToast.showText("居中显示")
        SMToast.showText("居中显示", duration: 5)
//        SMToast.showText("距顶部50像素", topOffset: 50)
        SMToast.showText("距顶部50像素", topOffset: 50, duration: 5)
        SMToast.showText("支持设定显示时间", topOffset: 100, duration: 5)
        SMToast.showText("文字很多时，将根据文字的内容自动多行显示。比如说这里将使用2行显示。", topOffset: 150, duration: 5)
        SMToast.showText("支持\'\\n\'，可\n显示\n多\n行", bottomOffset: 100, duration: 5)
        SMToast.showText("支持屏幕旋转时自动消失", bottomOffset: 40, duration: 5)
//        SMToast.showText("距底部5像素", bottomOffset: 5)
        SMToast.showText("距底部5像素", bottomOffset: 5, duration: 5)
    }
}