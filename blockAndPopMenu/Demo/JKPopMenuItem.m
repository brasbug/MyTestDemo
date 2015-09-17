//
//  JKPopMenuItem.m
//  Demo
//
//  Created by Jack on 15/8/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "JKPopMenuItem.h"

@implementation JKPopMenuItem

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        self.image = image;
        self.title = title;
    }
    return self;
}


@end
