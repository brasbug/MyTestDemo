//
//  JKPopMenuView.h
//  Demo
//
//  Created by Jack on 15/8/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPopMenuItem.h"


typedef void(^JKPopMenuDidSlectedCompledBlock)(NSInteger index, JKPopMenuItem *menuItem);


@interface JKPopMenu : UIView

- (instancetype)initWithMenus:(NSArray *)menus;
- (instancetype)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (void)showMenuAtPoint:(CGPoint)point;
- (void)showMenuOnView:(UIView *)view atPoint:(CGPoint)point;



@property (nonatomic, copy) JKPopMenuDidSlectedCompledBlock popMenuDidSlectedCompled;

@property (nonatomic, copy) JKPopMenuDidSlectedCompledBlock popMenuDidDismissCompled;

@end
