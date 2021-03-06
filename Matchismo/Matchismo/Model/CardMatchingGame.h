//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCards:(NSUInteger)num;
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

//other class should not be able to set the score.. Just read the score
@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, readonly) BOOL gameStarted;
@property (nonatomic) NSUInteger numberOfCardToMatch;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic, strong, readonly) NSArray *lastChosenCards;
@end
