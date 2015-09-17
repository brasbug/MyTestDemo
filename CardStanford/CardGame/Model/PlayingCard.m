//
//  PlayingCard.m
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+(NSArray *)validSuits
{
    NSArray * arrlist = [NSArray arrayWithObjects:@"红桃",@"黑桃",@"方块",@"梅花", nil];
    return arrlist;
}
+(NSInteger)maxRank
{
    return 52;
}

@end
