//
//  PlayingCard.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;


+ (NSArray *)validSuits {
	return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}
+ (NSArray *)rankStrings {
	return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}
+ (NSUInteger)maxRank {
	return [[PlayingCard rankStrings] count] -1;
}

- (void)setRank:(NSUInteger)rank {
	if (rank <= [[PlayingCard rankStrings] count] -1) {
		_rank = rank;
	}
}
- (NSString *)contents {
	return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void) setSuit:(NSString *)suit {
	if ([PlayingCard validSuits]) {
		_suit = suit;
	}
}

- (NSString *)suit {
	return _suit ? _suit : @"?";
}

- (int) match:(NSArray *)otherCards {
	int score = 0;
	NSUInteger numberOfOtherCards = otherCards.count;
	if (numberOfOtherCards) {
		for (Card *card in otherCards) {
			if ([card isKindOfClass:[PlayingCard class]]) {
				PlayingCard *otherCard = (PlayingCard *)card;
				if (otherCard.rank == self.rank) {
					score += 4;
				} else if ([otherCard.suit isEqualToString:self.suit]) {
					score += 1;
				}
			}
		}
	}
	if (numberOfOtherCards > 1) {
		score += [otherCards[0] match:[otherCards subarrayWithRange:NSMakeRange(1, numberOfOtherCards-1)]];
	}
	return score;
}

@end
