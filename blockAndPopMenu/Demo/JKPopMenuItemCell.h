//
//  JKPopMenuItemCell.h
//  Demo
//
//  Created by Jack on 15/8/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKPopMenuItem.h"


@interface JKPopMenuItemCell : UITableViewCell

@property (nonatomic, strong) JKPopMenuItem *popMenuItem;

- (void)setupPopMenuItem:(JKPopMenuItem *)popMenuItem atIndexPath:(NSIndexPath *)indexPath isBottom:(BOOL)isBottom;

@end
