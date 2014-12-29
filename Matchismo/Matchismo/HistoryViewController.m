//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Henry on 29/12/14.
//  Copyright (c) 2014 Henry. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)setHistory:(NSArray *)history {
	_history = history;
	if (self.view.window) [self updateUI];
}
- (void)updateUI {
	NSMutableAttributedString *fullHistoryAttributedText = [[NSMutableAttributedString alloc] init];
	for (id historyLine in self.history) {
		if ([historyLine isKindOfClass:[NSAttributedString class]]) {
			[fullHistoryAttributedText appendAttributedString:historyLine];
			[fullHistoryAttributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
		}
	}
	self.historyTextView.attributedText = fullHistoryAttributedText;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self updateUI];
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
