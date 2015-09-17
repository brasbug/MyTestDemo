//
//  JKPopMenuItem.h
//  Demo
//
//  Created by Jack on 15/8/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#define JKMenuTableViewWidth 130
#define JKMenuTableViewSapcing 7

#define JKMenuItemViewHeight 36
#define JKMenuItemViewImageSapcing 15
#define JKSeparatorLineImageViewHeight 0.5




@interface JKPopMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;


@end
