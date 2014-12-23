//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL gameStarted;
@property (nonatomic, strong) NSMutableArray *cards; //of Cards
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
	}
	return _cards;
}

- (NSUInteger) numberOfCardToMatch {
	if (_numberOfCardToMatch < 2) {
		_numberOfCardToMatch = 2;
	}
	return _numberOfCardToMatch;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
	self = [super init]; //super designated initializer
	if (self) {
		self.gameStarted = NO;
		for (int i = 0; i<count; i++) {
			Card *card = [deck drawRandomCard];
			if (card) {
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}
	}
	return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
	return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
	Card *card = [self cardAtIndex:index];
	self.gameStarted = YES;
	if (!card.isMatched) {
		if (card.isChosen) {
			card.chosen = NO;
		} else {
			//match against other cards
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					int matchScore = [card match:@[otherCard]];
					if (matchScore) {
						self.score += matchScore * MATCH_BONUS;
						otherCard.matched = YES;
						card.matched = YES;
					} else {
						self.score -= MISMATCH_PENALTY;
						otherCard.chosen = NO;
					}
					break;
				}
			}
			self.score -= COST_TO_CHOOSE;
			card.chosen = YES;
		}
		
	}
}




@end
