# 1 XM_NSNotification
这是一个保证NSNotification安全的小框架，能够安全的自动帮你移除监听器对象，注册监听器对象的方法和原方法类似，只需一行代码搞定，不用 再担心因忘记移除监听器而造成程序可能出现的种种问题了(The small framework which can guaranteed your nsnotification safty, can automatically help you remove the observer, the registered method is similar to the original method and only need a line of code. You do not have to worry about various problems caused by your APP because of forgetting to remove the observer)

# 2 使用(Usage)
## 2.1 Cocoapods
```
pod 'XM_NSNotification'
```
## 2.2 手动拖入
直接将XM_NSNotification文件夹拖入即可

## 3 示例如下(for example):


###  3.1 引入头文件（import header file)

```
#import "NSNotificationCenter+XM.h"
```

###  3.2 代码示例（code example）

//监听对象销毁前移除，也是默认的移除方法

//remove observer before observer crash (defaullt)

```
[[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(sina:) name:@"sina" object:nil];
```

//收到通知后立即移除监听对象

// remove observer after receiving notification right now
```
[[NSNotificationCenter defaultCenter] xm_addObserver:self selector:@selector(haha:) name:@"haha" object:nil isRightNowRemove:YES];
```

如果这个小框架有什么问题希望大家多多批评指正，这是我的新写的博客：http://blog.csdn.net/xmios/article/details/51637074 
我的邮箱：hnyxgxm2009@163.com
I hope everyone can help me correct the error if there are mistakes in the small framework.This is my blog which I has writen just now.This is my email hnyxgxm2009@163.com.
