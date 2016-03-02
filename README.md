# SMToast
A simple Toast notification, like Android Toast. Used Swift.
一个简单的Toast提示框，类似Android的Toast。使用Swift语言实现。

## How to use?
很简单的直接使用 SMToast.showText(...)

	//        SMToast.showText("居中显示")
	SMToast.showText("居中显示", duration: 5)
	//        SMToast.showText("距顶部50像素", topOffset: 50)
	SMToast.showText("距顶部50像素", topOffset: 50, duration: 5)
	SMToast.showText("支持设定显示时间", topOffset: 100, duration: 5)
	SMToast.showText("文字很多时，将根据文字的内容自动多行显示。比如说这里将使用2行显示。", topOffset: 150, duration: 5)
	SMToast.showText("支持\'\\n\'，可\n显示\n多\n行", bottomOffset: 100, duration: 5)
	SMToast.showText("支持屏幕旋转时自动消失", bottomOffset: 40, duration: 5)
	SMToast.showText("距底部5像素", bottomOffset: 5)
	SMToast.showText("距底部5像素", bottomOffset: 5, duration: 5)
	
##Features / 功能
效果图：

![DemoPic](/img_demo.PNG)

1. 支持显示多行文本
2. 支持设置显示时长
3. 支持距顶部、底部的距离
4. 支持点击Toast隐藏
5. 支持屏幕旋转时自动隐藏
6. 支持回车换行
7. 静态方法直接调用

##About Me
Contact me : softman123g@126.com

