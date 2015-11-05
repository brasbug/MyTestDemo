////
////  NVImageView.h
////  NVScope
////
////  Created by Tu Yimin on 09-11-18.
////  Copyright 2009 dianping.com. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//#import "NVImageCache.h"
//#import "NVMemCache.h"
//#import "NVOperationQueue.h"
//
//@interface NVImageShadow : UIView
//
//@end
//
//@protocol NVImageViewDelegate;
//@class NVImageGetTask;
//@interface NVImageView : UIImageView {
//    __unsafe_unretained id target;
//    SEL action;
//    Boolean isPressed;
//    NVImageShadow *shadowView;
//@public
//    NVImageGetTask *currentTask;
//    NVImageGetTask *highlightedTask;
//}
//@property (nonatomic, copy) NSString *ga_label;
//@property (nonatomic, strong) NSURL *imageUrl;
//@property (nonatomic, strong) NSURL *highlightedImageUrl;
//@property (nonatomic, assign) NSInteger index;
//@property (nonatomic, weak) id <NVImageViewDelegate> imageDownloadDelegate;
//
//@property (nonatomic, strong) UIImage *errImage;
//@property (nonatomic, strong) UIImage *loadingImage;
//@property (nonatomic, strong) UIImage *noPicImage;
//@property (nonatomic, strong) UIImage *centralImage;
//
////默认情况下loading时图片中心的icon会显示，但可以通过此flag将其隐藏
//@property (nonatomic, assign) BOOL loadingCentralIconHidden;
//@property (nonatomic, assign) BOOL notShowLoadingCentralIcon;
//
//@property (nonatomic,assign) NSInteger picContentMode;//要显示图片的contentMode
//@property (nonatomic,assign) NSInteger statusPicContentMode;//其它状态(无图,加载,错误)图片的contentMode
//
//- (UIImage *)noPicFrame;
//
//- (UIImage *)loadingFrame;
//
//- (UIImage *)errorFrame;
//
//
//- (void)setImageUrl:(NSURL *)url;
////isCacheSyncCallback: 当前url在缓存中时，是否需要同步回调
//- (void)setImageUrl:(NSURL *)url isCacheSyncCallback:(BOOL)isSync;
//
//
//+ (NVMemCache *)memCache;
//
//+ (void)loadImage:(NSString *)imageUrl;
//
//- (void)setTouchTarget:(id)target action:(SEL)selector;
//
//- (void)loadingFinish:(BOOL)succ;
//
//- (void)cancelLoading;
//
//+ (BOOL)isCached:(NSURL *)url;
//
//+ (UIImage *)cachedImage:(NSURL *)url;
//
//+ (UIImage *)cachedThumbImage:(NSString *)url;
//
//// fail if result=nil
//- (void)imageFetched:(NVImageGetTask *)task image:(UIImage *)image withURL:(NSURL *)url;
//
//- (void)setLoadingCentralIconHidden:(BOOL)hidden;
//- (UIImageView *)centralIcon;
//
//
//+ (BOOL)shouldShowPhoto;
//
//@end
//
//@protocol NVImageViewDelegate <NSObject>
//
//- (void)imageLoadingSucced:(NVImageView *)aImageView;
//- (void)imageLoadingFailed:(NVImageView *)aImageView;
//
//@end
//
//@class NVImageGetTask;
//typedef void (^NVImageGetTaskBlock)(NVImageGetTask *task, id result);
//
//@interface NVImageGetTask : NSObject <NVOperation>
//
//@property (nonatomic, retain) NSURL *url;
//@property (nonatomic, assign) NVImageView *imageView;
//@property (nonatomic, retain) id<NVImageCacheProtocol> cache;
//
//@property (nonatomic, retain) UIImage *result;
//@property (nonatomic, assign) BOOL isCanceled;
//@property (nonatomic, copy) NVImageGetTaskBlock imageGetBlock;
//
//@property (nonatomic, copy) NSString *ga_label;
//
//- (void)performOnMainThread;
//
//@end
//
