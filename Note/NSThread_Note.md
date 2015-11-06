NSThread:
优点：NSThread 比其他两个轻量级
缺点：需要自己管理线程的生命周期，线程同步。线程同步对数据的加锁会有一定的系统开销.

苹果官方资料：https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSThread_Class/index.html#//apple_ref/doc/uid/TP40003746



- (id)initWithTarget:(id)target selector:(SEL)selector object:(id)argument
+ (void)detachNewThreadSelector:(SEL)aSelector toTarget:(id)aTarget withObject:(id)anArgument

用NSObject的类方法  performSelectorInBackground:withObject: 创建一个线程：
[Obj performSelectorInBackground:@selector(doSomething) withObject:nil];



1、[NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];  

2、NSThread* myThread = [[NSThread alloc] initWithTarget:self  
                                        selector:@selector(doSomething:)  
                                        object:nil];  
[myThread start];  


 多个线程同时做一件事情， 保证数据同步就需要有一个同步锁了。





