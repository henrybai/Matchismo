//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Henry on 27/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
	
	self = [super init];
	//check if super initialiser has no errors
	if (self) {
		for (int num = 1; num <= 3; num++) {
			for (int symbol = 0; symbol < 3; symbol++) {
				for (int shade = 0; shade < 3; shade++) {
					for (int color = 0; color < 3; color++) {
						SetCard* card = [[SetCard alloc] initWithNumber:num symbol:symbol shade:shade color:color];
						[self addCard:card];
					}
				}
			}
			
		}
	}
	return self;
}

@end

