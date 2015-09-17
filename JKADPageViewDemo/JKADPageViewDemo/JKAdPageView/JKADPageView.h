//
//  JKADPageView.h
//  JKADPageViewDemo
//
//  Created by Jack on 15/8/27.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKADImageItem.h"

@class JKADPageView;
typedef void (^JKADPageCallBack)(long clickIndex);



@protocol JKADPageViewDelegate <NSObject>


- (void)setadsWebImage:(UIImageView *)imageView imageUrl:(NSString *)imageUrl;


- (void)clickItemAtIndext:(long)clickIndex imageModel:(JKADImageItem *)iamgeItme;

@end




@interface JKADPageView : UIView


@property (nonatomic, assign) NSInteger iDisplayTime;
@property (nonatomic, assign) BOOL isWebImage;
@property (nonatomic, assign) id<JKADPageViewDelegate> delegate;



//- (id)initWithFrame:(CGRect)frame imageArrs:(NSArray *)imageArray block:(JKADPageCallBack )block;


- (void)startAdsWithImageArray:(NSArray *)imageArr;


@end
