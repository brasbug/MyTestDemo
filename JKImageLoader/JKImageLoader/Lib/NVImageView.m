////
////  NVImageView.m
////  NVScope
////
////  Created by Tu Yimin on 09-11-18.
////  Copyright 2009 dianping.com. All rights reserved.
////
//
//#import "NVImageView.h"
//#import "NVOperationQueue.h"
//#import "UIImage+Utilities.h"
//#import "NVMonitorCenter.h"
//#import "UIScreen+Adaptive.h"
//#import "UIResponder+informer.h"
//#import "R.h"
//#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
//
//@interface NVImageViewManager : NSObject {
//    NVMemCache *memCache;
//    NVOperationQueue *queue;
//}
//
//+ (NVImageViewManager *)sharedInstance;
//
//- (NVMemCache *)memCache;
//- (NVOperationQueue *)queue;
//
//- (void)didEnterBackground:(NSNotification *)n;
//- (void)willTerminate:(NSNotification *)n;
//- (void)memoryWarning:(NSNotification *)n;
//
//@end
//
//@interface NVImageView () {
//    NSURL *imageUrl;
//    NSURL *highlightedImageUrl;
//    UIImageView* _centralIconView;
//}
//
//- (NVOperationQueue *)myQueue;
//- (id<NVImageCacheProtocol>)myCache;
//
//- (void)requestURL:(NSURL *)url;
//
//@end
//
//
//@implementation NVImageViewManager
//
//+ (NVImageViewManager *)sharedInstance {
//    static NVImageViewManager *__ivm  = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        __ivm = [[NVImageViewManager alloc] init];
//        [[NSNotificationCenter defaultCenter] addObserver:__ivm selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:__ivm selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:__ivm selector:@selector(memoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
//    });
//    return __ivm;
//}
//
//- (NVMemCache *)memCache {
//    if(memCache == nil) {
//        memCache = [[NVMemCache alloc] initWithMaxSize:128 maxLifetime:0];
//    }
//    return memCache;
//}
//
//- (NVOperationQueue *)queue {
//    if(!queue) {
//        queue = [[NVOperationQueue alloc] initWithThreadCount:3];
//    }
//    return queue;
//}
//
//- (void)didEnterBackground:(NSNotification *)n {
//    //    [memCache clear];
//}
//
//- (void)willTerminate:(NSNotification *)n {
//    
//}
//
//- (void)memoryWarning:(NSNotification *)n {
//    [memCache clear];
//}
//
//@end
//
//
//@implementation NVImageShadow
//
//- (id)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.alpha = 0.5;
//    }
//    return self;
//}
//
//- (void)drawRect:(CGRect)rect {
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    
//    UIColor *shadowColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
//    [shadowColor set];
//    CGContextFillRect(currentContext, rect);
//}
//
//@end
//
//
//@implementation NVImageGetTask
//
//@synthesize url, imageView, cache, result, isCanceled;
//
//- (void)main {
//    if(isCanceled)
//        return;
//    
//    
//    @try {
//        result = nil;
//        
//        // try cache first
//        NSData *data = [cache fetch:[url absoluteString]];
//        
//        if(data) {
//            result = [UIImage imageWithData:data];
//        }
//        if(isCanceled)
//            return;
//        if(result) {
//            [self performSelectorOnMainThread:@selector(performOnMainThread) withObject:nil waitUntilDone:NO];
//            return;
//        }
//        
//        
//        // then try the network
//        NSTimeInterval startTime = [[NSDate date] timeIntervalSince1970];
//        
//        NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
//        NSURLResponse *resp = nil;
//        data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:NULL];
//        if(data && [resp isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)resp statusCode] / 100 == 2) {
//            result = [UIImage imageWithData:data];
//        }
//        
//        NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
//        NSTimeInterval time = endTime - startTime;
//        int millis = time * 1000;
//        
//        NSInteger code = [resp isKindOfClass:[NSHTTPURLResponse class]] ? [(NSHTTPURLResponse *)resp statusCode] : 200;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[NVMonitorCenter defaultCenter] pvWithCommand:[NSString stringWithFormat:@"_pic_%@",[self.url absoluteString]] network:0 code:(int)code requestBytes:0 responseBytes:(int)data.length responseTime:millis];
//            if (self.ga_label.length > 0) {
//                NSString *command = [NSString stringWithFormat:@"pic.down.%@", self.ga_label];
//                [[NVMonitorCenter defaultCenter] pvWithCommand:command network:0 code:(int)code requestBytes:0 responseBytes:(int)data.length responseTime:millis];
//            }
//        });
//        
//        if(!isCanceled) {
//            
//            [self performSelectorOnMainThread:@selector(performOnMainThread) withObject:nil waitUntilDone:NO];
//        }
//        if(result) {
//            [cache push:data forKey:[url absoluteString]];
//        }
//    }
//    @finally {
//    }
//}
//
//- (void)performOnMainThread {
//    if(isCanceled)
//        return;
//    if(imageView != nil && (imageView->currentTask == self || imageView->highlightedTask == self)) {
//        [imageView imageFetched:self image:result withURL:url];
//    }
//    if (self.imageGetBlock) {
//        self.imageGetBlock(self, result);
//    }
//}
//
//@end
//
//
//@implementation NVImageView
//
//@dynamic imageUrl;
//@dynamic highlightedImageUrl;
//@synthesize index;
//@synthesize imageDownloadDelegate = _imageDownloadDelegate;
//@synthesize errImage,loadingImage,noPicImage;
//@synthesize loadingCentralIconHidden;
//
//- (id)initWithFrame:(CGRect)frameRect {
//    self = [super initWithFrame:frameRect];
//    if (self) {
//        self.exclusiveTouch = YES;
//    }
//    return self;
//}
//
//+ (NVMemCache *)memCache {
//    return [[NVImageViewManager sharedInstance] memCache];
//}
//
//- (NSURL *)imageUrl {
//    return imageUrl;
//}
//
//- (UIImage *)noPicFrame {
//    if (self.noPicImage) {
//        self.contentMode = self.statusPicContentMode;
//        return self.noPicImage;
//    }
//    return nil;
//}
//
//- (UIImage *)errorFrame {
//    if (self.errImage) {
//        self.contentMode = self.statusPicContentMode;
//        return self.errImage;
//    }
//    return nil;
//}
//
//- (UIImage *)loadingFrame {
//    if (self.loadingImage) {
//        self.contentMode = self.statusPicContentMode;
//        return self.loadingImage;
//    }
//    else
//    {
//        return [UIImage imageWithColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
//    }
//}
//
//- (UIImageView *)centralIcon
//{
//    if (self.notShowLoadingCentralIcon) {
//        return nil;
//    }
//    
//    if (!self.centralImage) {
//        self.centralImage = [UIImage imageNamed:R_default_imageView_icon];
//    }
//    
//    UIImageView* centralIconImageView = [[UIImageView alloc] initWithImage:self.centralImage];
//    
//    if (self.centralImage.size.width > self.frame.size.width - 10 && self.centralImage.size.height > self.frame.size.height - 10) {
//        centralIconImageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    
//    centralIconImageView.contentMode = UIViewContentModeScaleAspectFit;
//    centralIconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
//    UIViewAutoresizingFlexibleRightMargin |
//    UIViewAutoresizingFlexibleTopMargin |
//    UIViewAutoresizingFlexibleBottomMargin;
//    return centralIconImageView;
//}
//
//- (void)setLoadingCentralIconHidden:(BOOL)hidden
//{
//    if (self.notShowLoadingCentralIcon) {
//        return;
//    }
//    
//    if (!hidden) {
//        if (_centralIconView == nil) {
//            _centralIconView = [self centralIcon];
//            if (_centralIconView) {
//                CGRect frame = _centralIconView.frame;
//                frame.origin = CGPointZero;
//                _centralIconView.frame = frame;
//                _centralIconView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//                [self addSubview:_centralIconView];
//            }
//        }
//    }
//    else
//    {
//        [_centralIconView removeFromSuperview];
//        _centralIconView = nil;
//    }
//}
//
//- (void)setTouchTarget:(id)t action:(SEL)s {
//    target = t;
//    action = s;
//    
//    //	if (t && s && shadowView == nil) {
//    //		shadowView = [[NVImageShadow alloc] initWithFrame:self.bounds];
//    //		shadowView.hidden = YES;
//    //		[self addSubview:shadowView];
//    //	}
//}
//
//- (void)setImageUrl:(NSURL *)url isCacheSyncCallback:(BOOL)isSync {
//    if ([[url absoluteString] length]<1) {
//        url = nil;
//    }
//    
//    // 如果两次url相等
//    if([url isEqual:imageUrl]) {
//        if(url == nil) {
//            [self setImage:[self noPicFrame]];
//            [self loadingFinish:NO];
//            [self setLoadingCentralIconHidden:YES];
//        }
//        
//        // 如果正在加载，返回
//        if (self.image == [self loadingFrame]) {
//            return;
//        }
//        // 如果不是错误图片，并且也不是空图片
//        else if (self.image != [self errImage] && self.image != [self noPicImage]) {
//            return;
//        }
//    }
//    imageUrl = url;
//    
//    currentTask.isCanceled = YES;
//    currentTask.imageView = nil;
//    currentTask = nil;
//    UIImage *cached = url ? [[NVImageView memCache] objectForKey:url] : nil;
//    // 判断是否存在本地图片缓存
//    if (!cached) {
//        cached = [UIImage imageWithData:[[self myCache] fetch:[url absoluteString]]];
//    }
//    if(cached) {
//        [self setImage:cached];
//        if (isSync) {
//            [self notifyFinished];
//        } else {
//            [self performSelectorOnMainThread:@selector(notifyFinished) withObject:nil waitUntilDone:NO];
//        }
//        
//    } else if(url) {
//        [self setLoadingCentralIconHidden:NO];
//        [self setImage:[self loadingFrame]];
//    } else {
//        [self setImage:[self noPicFrame]];
//        [self loadingFinish:NO];
//        [self setLoadingCentralIconHidden:YES];
//    }
//    if(cached == nil && url) {
//        [self requestURL:url];
//    }
//}
//
//- (void)setImageUrl:(NSURL *)url {
//    [self setImageUrl:url isCacheSyncCallback:YES];
//}
//
//- (void)notifyFinished {
//    [self loadingFinish:YES];
//    [self setLoadingCentralIconHidden:YES];
//}
//
//- (void)setHighlightedImageUrl:(NSURL *)url
//{
//    if ([[url absoluteString] length]<1) {
//        url = nil;
//    }
//    if(url == highlightedImageUrl) {
//        if(url == nil) {
//            [self setHighlightedImage:nil];
//        }
//        return;
//    }
//    BOOL equals = [url isEqual:highlightedImageUrl];
//    highlightedImageUrl = url;
//    if(equals && (self.highlightedImage != [self loadingFrame]))
//        return;
//    
//    highlightedTask.isCanceled = YES;
//    highlightedTask.imageView = nil;
//    highlightedTask = nil;
//    UIImage *cached = url ? [[NVImageView memCache] objectForKey:url] : nil;
//    // 判断是否存在本地图片缓存
//    if (!cached) {
//        cached = [UIImage imageWithData:[[self myCache] fetch:[url absoluteString]]];
//    }
//    if(cached) {
//        [self setHighlightedImage:cached];
//    } else if(url) {
//        [self setHighlightedImage:nil];
//    } else {
//        [self setHighlightedImage:nil];
//    }
//    if(cached == nil && url) {
//        [self requestHighlightedURL:url];
//    }
//    
//}
//
//- (void)requestURL:(NSURL *)url {
//    NVImageGetTask *task = [[NVImageGetTask alloc] init];
//    task.ga_label = self.ga_label;
//    task.url = url;
//    task.imageView = self;
//    task.cache = [self myCache];
//    currentTask = task;
//    [[self myQueue] addOperation:task];
//}
//
//- (void)requestHighlightedURL:(NSURL *)url {
//    NVImageGetTask *task = [[NVImageGetTask alloc] init];
//    task.ga_label = self.ga_label;
//    task.url = url;
//    task.imageView = self;
//    task.cache = [self myCache];
//    highlightedTask = task;
//    [[self myQueue] addOperation:task];
//}
//
//// fail if result=nil
//- (void)imageFetched:(NVImageGetTask *)task image:(UIImage *)image withURL:(NSURL *)url {
//    if (task == currentTask) {
//        if(image) {
//            CGSize size = [image size];
//            if(size.width * size.height < 128*128) {
//                [[NVImageView memCache] putObject:image forKey:url];
//            }
//            [self setImage:image];
//            [self loadingFinish:YES];
//            currentTask.isCanceled = YES;
//            currentTask = nil;
//        } else {
//            [self setImage:[self errorFrame]];
//            [self loadingFinish:NO];
//            currentTask.isCanceled = YES;
//            currentTask = nil;
//        }
//        [self setLoadingCentralIconHidden:YES];
//    } else if (task == highlightedTask) {
//        if(image) {
//            CGSize size = [image size];
//            if(size.width * size.height < 128*128) {
//                [[NVImageView memCache] putObject:image forKey:url];
//            }
//            [self setHighlightedImage:image];
//            highlightedTask.isCanceled = YES;
//            highlightedTask = nil;
//        } else {
//            [self setHighlightedImage:nil];
//            highlightedTask.isCanceled = YES;
//            highlightedTask = nil;
//        }
//    }
//    
//    if(image)
//    {
//        if (self.picContentMode) {
//            self.contentMode = self.picContentMode;
//        }
//    }
//}
//
//- (NVOperationQueue *)myQueue {
//    return [[NVImageViewManager sharedInstance] queue];
//}
//- (id<NVImageCacheProtocol>)myCache {
//    return [[NVImageCacheManager sharedInstance] thumbCache];
//}
//
//+ (void)loadImage:(NSString *)imageUrl
//{
//    NVImageGetTask *task = [[NVImageGetTask alloc] init];
//    task.url = [NSURL URLWithString:imageUrl];
//    task.cache = [[NVImageCacheManager sharedInstance] thumbCache];
//    task.imageGetBlock = ^(NVImageGetTask * task, id result){
//        [task.cache push:UIImagePNGRepresentation(result) forKey:task.url.absoluteString];
//    };
//    [[[NVImageViewManager sharedInstance] queue] addOperation:task];
//}
//
//+ (BOOL)isCached:(NSURL *)url {
//    if (url) {
//        if ([[NVImageView memCache] objectForKey:url]!=nil) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//+ (UIImage *)cachedImage:(NSURL *)url {
//    UIImage *cached = url ? [[NVImageView memCache] objectForKey:url] : nil;
//    return cached;
//}
//
//+ (UIImage *)cachedThumbImage:(NSString *)url
//{
//    NSData *data = [[[NVImageCacheManager sharedInstance] thumbCache] fetch:url];
//    if (data != nil) {
//        return [UIImage imageWithData:data];
//    }
//    return nil;
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    isPressed = YES;
//    
//    if (shadowView) {
//        shadowView.hidden = NO;
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    if (shadowView) {
//        shadowView.hidden = !CGRectContainsPoint(self.bounds, touchPoint);
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint = [touch locationInView:self];
//    if (isPressed && CGRectContainsPoint(self.bounds, touchPoint)) {
//        isPressed = NO;
//        if (shadowView) {
//            shadowView.hidden = YES;
//        }
//        
//        [self ga_logEventType:NVGaEventTypeTap];
//        if (target && action) {
//            if ([target respondsToSelector:action]) {
//                [target performSelector:action withObject:self];
//            }
//        }
//    }
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//}
//
//- (void)loadingFinish:(BOOL)succ {
//    if (_imageDownloadDelegate) {
//        if (succ && [_imageDownloadDelegate respondsToSelector:@selector(imageLoadingSucced:)]) {
//            [_imageDownloadDelegate imageLoadingSucced:self];
//        } else if ([_imageDownloadDelegate respondsToSelector:@selector(imageLoadingFailed:)]){
//            [_imageDownloadDelegate imageLoadingFailed:self];
//        }
//    }
//}
//
//- (void)cancelLoading {
//    currentTask.isCanceled = YES;
//    currentTask.imageView = nil;
//    currentTask = nil;
//    
//    highlightedTask.isCanceled = YES;
//    highlightedTask.imageView = nil;
//    highlightedTask = nil;
//}
//
//- (void)dealloc {
//    currentTask.isCanceled = YES;
//    currentTask.imageView = nil;
//    currentTask = nil;
//    
//    highlightedTask.isCanceled = YES;
//    highlightedTask.imageView = nil;
//    highlightedTask = nil;
//    
//    _imageDownloadDelegate = nil;
//    
//    target = nil;
//}
//
//+ (BOOL)shouldShowPhoto {
//    return NO;
//}
//
//@end
