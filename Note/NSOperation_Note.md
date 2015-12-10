





NSOperation表示了一个独立的计算单元。作为一个抽象类，它给了它的子类一个十分有用而且线程安全的方式来建立状态、优先级、依赖性和取消等的模型。或者，你不是很喜欢再自己继承NSOperation的话，框架还提供NSBlockOperation，这是一个继承自NSOperation且封装了block的实体类。

很多执行任务类型的案例都很好的运用了NSOperation，包括网络请求，图像压缩，自然语言处理或者其他很多需要返回处理后数据的、可重复的、结构化的、相对长时间运行的任务。

但是仅仅把计算封装进一个对象而不做其他处理显然没有多大用处，我们还需要NSOperationQueue来大显身手。

NSOperationQueue控制着这些并行操作的执行，它扮演者优先级队列的角色，让它管理的高优先级操作(NSOperation -queuePriority)能优先于低优先级的操作运行的情况下，使它管理的操作能基本遵循先进先出的原则执行。此外，在你设置了能并行运行的操作的最大值(maxConcurrentOperationCount)之后，NSOperationQueue还能并行执行操作。

让一个NSOperation操作开始，你可以直接调用-start，或者将它添加到NSOperationQueue中，添加之后，它会在队列排到它以后自动执行。

现在让我们通过怎样使用和怎样通过继承实现功能来看看NSOperation稍微复杂的部分。


状态

NSOperation包含了一个十分优雅的状态机来描述每一个操作的执行。

isReady → isExecuting → isFinished

为了替代不那么清晰的state属性，状态直接由上面那些keypath的KVO通知决定，也就是说，当一个操作在准备好被执行的时候，它发送了一个KVO通知给isReady的keypath，让这个keypath对应的属性isReady在被访问的时候返回YES。

每一个属性对于其他的属性必须是互相独立不同的，也就是同时只可能有一个属性返回YES，从而才能维护一个连续的状态： - isReady: 返回 YES 表示操作已经准备好被执行, 如果返回NO则说明还有其他没有先前的相关步骤没有完成。 - isExecuting: 返回YES表示操作正在执行，反之则没在执行。 - isFinished : 返回YES表示操作执行成功或者被取消了，NSOperationQueue只有当它管理的所有操作的isFinished属性全标为YES以后操作才停止出列，也就是队列停止运行，所以正确实现这个方法对于避免死锁很关键。



•NSOperation：
–不需要关心线程管理，数据同步的事情，可以把精力放在自己需要执行的操作上
–NSOperation是面向对象的

//实例化操作队列  只要将操作添加到队列NSOperationQueue即可启动多线程执行
_queue = [[NSOperationQueue alloc] init];

// 控制同时最大并发的线程数量 
 [_queue setMaxConcurrentOperationCount:2];


#NSInvocationOperation


 NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(opAction) object:nil];  
// 如果使用start，会在当前线程启动操作
 [op1 start];
    
 // 1. 一旦将操作添加到操作队列，操作就会启动
 [_queue addOperation:op1];





NSBlockOperation
#pragma mark 模仿下载网络图像
- (IBAction)operationDemo3:(id)sender
{
    // 1. 下载
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载 %@" , [NSThread currentThread]);
    }];
    // 2. 滤镜
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"滤镜 %@" , [NSThread currentThread]);
    }];
    // 3. 显示
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"更新UI %@" , [NSThread currentThread]);
    }];
    
    // 添加操作之间的依赖关系，所谓“依赖”关系，就是等待前一个任务完成后，后一个任务才能启动
    // 依赖关系可以跨线程队列实现
    // 提示：在指定依赖关系时，注意不要循环依赖，否则不工作。
    [op2 addDependency:op1];
    [op3 addDependency:op2];
//    [op1 addDependency:op3];
    
    [_queue addOperation:op1];
    [_queue addOperation:op2];
    [[NSOperationQueue mainQueue] addOperation:op3];
}






