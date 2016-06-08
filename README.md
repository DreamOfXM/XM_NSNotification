# XM_NSNotification
这是一个保证NSNotification安全的小框架，能够安全的自动帮你移除监听器对象，注册监听器对象的方法和原方法类似，只需一行代码搞定，不用 再担心因忘记移除监听器而造成程序可能出现的种种问题了(The small framework which can guaranteed your nsnotification sadty, can automatically help you remove the observer, the registered method is similar to the original method and only need a line of code. You do not have to worry about various problems caused by your APP because of forgetting to remove the observer)

##示例如下(for example):

###1.引入头文件（import header file)

```
#import "NSNotificationCenter+XM.h"
```

###2.代码示例（code example）

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