//
//  Deck.m
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "Deck.h"

@implementation Deck

- (id)init
{
    self = [super init];
    if (self) {
        self.arrlist = [NSMutableArray array];
    }
    return self;
}

- (void)addCard:(PlayingCard *)card
{
    [self.arrlist addObject:card];
}

@end
