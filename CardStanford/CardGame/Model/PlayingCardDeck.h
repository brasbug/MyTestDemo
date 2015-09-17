//
//  PlayingCardDeck.h
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface PlayingCardDeck : Deck
@property (nonatomic, strong) NSMutableArray *cardMutArr;

@end
