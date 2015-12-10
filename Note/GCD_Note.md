–Grand Central Dispatch是由苹果开发的一个多核编程的解决方案。iOS4.0+才能使用，是替代NSThread， NSOperation的高效和强大的技术
–GCD是基于C语言的

GCD是苹果公司为多核的并行运算提出的解决方案

GCD会自动利用更多的CPU内核（比如双核、四核）

GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）

程序员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
(1)GCD存在于libdispatch.dylib这个库中，这个调度库包含了GCD的所有的东西，但任何IOS程序，默认就加载了这个库，在程序运行的过程中会动态的加载这个库，不需要我们手动导入。
(2)GCD是纯C语言的，因此我们在编写GCD相关代码的时候，面对的函数，而不是方法。
(3)GCD中的函数大多数都以dispatch开头。


任务和队列
GCD中有2个核心概念

（1）任务：执行什么操作

（2）队列：用来存放任务

 

GCD的使用就2个步骤

（1）定制任务

（2）确定想做的事情

 

将任务添加到队列中，GCD会自动将队列中的任务取出，放到对应的线程中执行

提示：任务的取出遵循队列的FIFO原则：先进先出，后进后出




执行任务
1.GCD中有2个用来执行任务的函数
说明：把右边的参数（任务）提交给左边的参数（队列）进行执行。
（1）用同步的方式执行任务 dispatch_sync(dispatch_queue_t queue, dispatch_block_t block);
参数说明：
queue：队列
block：任务
（2）用异步的方式执行任务 dispatch_async(dispatch_queue_t queue, dispatch_block_t block);
2.同步和异步的区别
同步：在当前线程中执行
异步：在另一条线程中执行


使用dispatch_get_global_queue函数获得全局的并发队列

dispatch_queue_t dispatch_get_global_queue(dispatch_queue_priority_t priority,unsigned long flags); // 此参数暂时无用，用0即可

示例：

这个参数是留给以后用的，暂时用不上，传个0。
第一个参数为优先级，这里选择默认的。获取一个全局的默认优先级的并发队列。
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 获得全局并发队列


dispatch_queue_t queue = dispatch_queue_create("wendingding", NULL); // 创建

dispatch_release(queue); // 非ARC需要释放手动创建的队列



主队列是GCD自带的一种特殊的串行队列,放在主队列中的任务，都会放到主线程中执行

使用dispatch_get_main_queue()获得主队列

示例：

dispatch_queue_t queue = dispatch_get_main_queue();

说明：全局并发队列的优先级

#define DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高

#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）

#define DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低

#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台


    //1.获得全局的并发队列
   dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.添加任务到队列中，就可以执行任务
    //异步函数：具备开启新线程的能力
    dispatch_async(queue, ^{
        NSLog(@"下载图片1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2----%@",[NSThread currentThread]);
    });
//打印主线程
    NSLog(@"主线程----%@",[NSThread mainThread]);
    