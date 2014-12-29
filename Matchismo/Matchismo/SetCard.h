//
//  SetCard.h
//  Matchismo
//
//  Created by Henry on 27/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSUInteger, SetCardSymbol) {
	SetCardSymbolCircle,
	SetCardSymbolTriangle,
	SetCardSymbolSquare
};

typedef NS_ENUM(NSUInteger, SetCardShade) {
	SetCardShadeSolid,
	SetCardShadeStripe,
	SetCardShadeOpen
};

typedef NS_ENUM(NSUInteger, SetCardColor) {
	SetCardColorRed,
	SetCardColorPurple,
	SetCardColorGreen
};

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) SetCardShade shade;
@property (nonatomic) SetCardColor color;


-(instancetype) initWithNumber:(NSUInteger)cardNumber
						symbol:(SetCardSymbol)cardSymbol
						 shade:(SetCardShade)cardShade
						 color:(SetCardColor)cardColor;

@end

