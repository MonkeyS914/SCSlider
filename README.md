# SCSlider
侧滑导航栏
# SCSliderViewController ViewcController侧滑效果 左滑右滑拉出侧边菜单栏 

![image](https://raw.githubusercontent.com/MonkeyS914/SCSlider/master/screenshot/123.gif?2)

简单集成 

使用方法，把SCSliderViewController文件夹拖到自己工程下面 

import SliderMenu.h 

在你的代码中添加下面一段
SliderMenu *sliderMenuViewController = [[SliderMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController rightMenuViewController:rightMenuViewController]; 


//添加背景图片 

sliderMenuViewController.backgroundImage = [UIImage imageNamed:@"back.jpg"]; 

//设置代理 

sliderMenuViewController.delegate = self; 

//添加手势识别 

sliderMenuViewController.enableGesture = YES; 

//设置动画时间 

sliderMenuViewController.animationDuration = 0.4f; 

还有其他参数可以在SliderMenu.m文件parameterInit函数里面设置



![image](http://ww4.sinaimg.cn/bmiddle/7cafd2d5jw1euuga1hspvj20ku112tfm.jpg)
![image](http://ww4.sinaimg.cn/bmiddle/7cafd2d5jw1euuga0t1kfj20ku112gsg.jpg) 
![image](http://ww3.sinaimg.cn/bmiddle/7cafd2d5jw1euug9ytn6rj20ku1120vz.jpg)
![image](http://ww3.sinaimg.cn/bmiddle/7cafd2d5jw1euug9y1fhxj20ku112q4s.jpg) 



