//
//  Deck.h
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCard.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *arrlist;

- (void)addCard:(PlayingCard *)card;

@end
