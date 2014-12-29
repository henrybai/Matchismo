//
//  SetCard.m
//  Matchismo
//
//  Created by Henry on 27/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(instancetype) initWithNumber:(NSUInteger)cardNumber
						symbol:(SetCardSymbol)cardSymbol
						 shade:(SetCardShade)cardShade
						 color:(SetCardColor)cardColor {
	self = [super init];
	if (self) {
		self.number = cardNumber;
		self.symbol = cardSymbol;
		self.shade = cardShade;
		self.color = cardColor;
	}
	return self;
}

-(void)setNumber:(NSUInteger)number{
	if (number < 1) {
		number = 1;
	} else if (number > 3) {
		 number= 3;
	}
	_number = number;
	
}
-(NSString *)contents {
	return nil;
}


- (int)match:(NSArray *)otherCards {
	if (otherCards.count != 2 || ![otherCards[0] isKindOfClass:[SetCard class]] || ![otherCards[1] isKindOfClass:[SetCard class]]) return 0;
	SetCard *firstCard = otherCards[0];
	SetCard *secondCard = otherCards[1];
	int score = 0;
	if (
		((self.number == firstCard.number && firstCard.number == secondCard.number) || (self.number != firstCard.number && firstCard.number != secondCard.number && self.number != secondCard.number))
		&& ((self.symbol == firstCard.symbol && firstCard.symbol == secondCard.symbol) || (self.symbol != firstCard.symbol && firstCard.symbol != secondCard.symbol && self.symbol != secondCard.symbol))
		&& ((self.shade == firstCard.shade && firstCard.shade == secondCard.shade) || (self.shade != firstCard.shade && firstCard.shade != secondCard.shade && self.shade != secondCard.shade))
		&& ((self.color == firstCard.color && firstCard.color == secondCard.color) || (self.color != firstCard.color && firstCard.color != secondCard.color && self.color != secondCard.color)) )
		{
			score = 5;
		}
	
	return score;
}

@end
