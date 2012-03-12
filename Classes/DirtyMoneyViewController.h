//
//  DirtyMoneyViewController.h
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirtyMoneyViewController : UIViewController {

	int mainInt;
	float dollaInt;
	float rate;
	float floatTot;
	IBOutlet UILabel *bankTot;
	IBOutlet UILabel *label;
	IBOutlet UILabel *dollas;
	NSTimer * randomMain;
	NSNumber * total;
	IBOutlet UITextField * rate2;
	IBOutlet UILabel * hourlyRate;
	UIButton * start;
	UIButton * stop;
	UIButton * bank;
	UIButton * copy;	
	UIButton * clearCount;
	UIButton * clearBank;

}

- (IBAction) copy:(id)sender;
- (IBAction) start:(id)sender;
- (IBAction) stop:(id)sender;
- (IBAction) bank:(id)sender;
- (IBAction) clearCount:(id)sender;
- (IBAction) clearBank:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *dollas;
@property (nonatomic, retain) IBOutlet UITextField *rate2;
@property (nonatomic, retain) IBOutlet UILabel *hourlyRate;

@end

