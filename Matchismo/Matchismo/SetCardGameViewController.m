//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Henry on 27/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController



- (Deck *)createDeck {
	return [[SetCardDeck alloc] init];
}

- (NSUInteger)numberOfCardsToMatch {
	return 3;
}

- (NSString *)titleForCard:(Card *)card {
	return [self titleForCard:card withSeperator:@""];
}



- (NSString *)titleForCard:(Card *)card withSeperator:(NSString *)seperator{
	SetCard *setCard = (SetCard *)card;
	NSString *symbol = @"";
	if (setCard.symbol == SetCardSymbolCircle) {
		symbol = @"●";
	} else if (setCard.symbol == SetCardSymbolSquare) {
		symbol = @"■";
	} else if (setCard.symbol == SetCardSymbolTriangle) {
		symbol =  @"▲";
	} else {
		symbol = @"";
	}
	NSMutableArray *symbolArray = [[NSMutableArray alloc] init];
	for(int i=0; i<setCard.number; i++) {
		[symbolArray addObject:symbol];
	}
	return [symbolArray componentsJoinedByString:seperator];
}

- (NSAttributedString *)cardFaceTitleForCard:(Card *)card{
	SetCard *setCard = (SetCard *)card;
	NSAttributedString *title = [[NSAttributedString alloc] initWithString:[self titleForCard:card withSeperator:@"\n"]
																attributes:@{NSStrokeWidthAttributeName: [self shadeForCard:setCard],
																			 NSForegroundColorAttributeName: [self colorForCard:setCard],
																			 NSStrokeColorAttributeName: [self colorForCard:setCard]
																			 }
								 ];
	return title;
	
}
- (NSAttributedString *)attributedTitleForCard:(Card *)card{
	SetCard *setCard = (SetCard *)card;
	NSAttributedString *title = [[NSAttributedString alloc] initWithString:[self titleForCard:card withSeperator:@""]
																attributes:@{NSStrokeWidthAttributeName: [self shadeForCard:setCard],
																			 NSForegroundColorAttributeName: [self colorForCard:setCard],
																			 NSStrokeColorAttributeName: [self colorForCard:setCard]
																			 }
								 ];
	return title;
	
}



- (UIImage *)imageForCard:(Card *)card {
	return card.isChosen ? [UIImage imageNamed:@"setcardselected"] : [UIImage imageNamed:@"cardfront"];
}


- (UIColor *)colorForCard:(SetCard *)setCard {
	UIColor *color = [UIColor blackColor];
	if (setCard.color == SetCardColorGreen) {
		color = [UIColor greenColor];
	} else if (setCard.color == SetCardColorPurple) {
		color = [UIColor purpleColor];
	} else if (setCard.color == SetCardColorRed) {
		color = [UIColor redColor];
	}
	if (setCard.shade == SetCardShadeStripe) {
		color = [color colorWithAlphaComponent:0.2];
	}
	return color;
}


- (NSNumber *)shadeForCard:(SetCard *)setCard {
	NSNumber *num = @0.0;
	if (setCard.shade ==  SetCardShadeOpen) {
		num = @10.0;
	} else if (setCard.shade == SetCardShadeSolid || setCard.shade == SetCardShadeStripe) {
		num = @-10.0;
	}
	return num;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
