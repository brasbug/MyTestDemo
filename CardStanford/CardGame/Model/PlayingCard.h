//
//  PlayingCard.h
//  CardGame
//
//  Created by Jack on 15/8/21.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayingCard : NSObject

@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) NSString* suit;

+(NSArray*)validSuits;

+(NSInteger)maxRank;

@end
