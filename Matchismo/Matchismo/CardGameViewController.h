//
//  ViewController.h
//  Matchismo
//
//  Created by Henry on 15/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

//Abstract class. Must implement methods below

@interface CardGameViewController : UIViewController


- (Deck *)createDeck; //abstract

@end

