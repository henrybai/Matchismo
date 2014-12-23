//
//  Card.m
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "Card.h"

@interface Card()
//Private Methods

@end

@implementation Card

- (int)match:(NSArray *)otherCards {
	int score = 0;
	for (Card *card in otherCards) {
		if ([card.contents isEqualToString:self.contents]) {
			score = 1;
		}
	}
	
	
	return score;
}
@end
