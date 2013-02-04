//
//  DirtyMoneyViewController.h
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"


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
	IBOutlet UILabel * hourlyRate;
	UIButton * start;
	UIButton * stop;
	UIButton * bank;
	UIButton * clearBank;
    UIButton * fbButton;
    Facebook *facebook;

}

- (IBAction) start:(id)sender;
- (IBAction) stop:(id)sender;
- (IBAction) bank:(id)sender;
- (IBAction) clearBank:(id)sender;
- (IBAction) fbButton: (id)sender;
- (IBAction) sliderChanged:(id)sender;

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *dollas;
@property (nonatomic, retain) IBOutlet UILabel *hourlyRate;

@end