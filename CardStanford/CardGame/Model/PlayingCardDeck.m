//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.cardMutArr = [NSMutableArray array];
        for ( NSString *suit in [PlayingCard validSuits]) {
            for (long rank = 1; i <= [PlayingCard maxRank] ; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.suit = suit;
                card.rank = rank;
//                [self.cardMutArr addObject:card];
                [self addCard:card];
            }
        }
    }
    return self;
}



@end
