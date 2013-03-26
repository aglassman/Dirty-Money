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
	float dollaInt, rate, floatTot, slideValue, pennySlideValue;
	IBOutlet UILabel *lifeTotal;
	IBOutlet UILabel *label;
	IBOutlet UILabel *dollas;
	NSTimer * randomMain;
	NSNumber * total;
	IBOutlet UILabel * hourlyRate;
    Facebook *facebook;
    NSArray *permissions;
    UISlider *slider, *pennySlider;
    NSUserDefaults *defaultsRate;
    NSInteger time;
}

- (IBAction) start:(id)sender;
- (IBAction) stop:(id)sender;
- (IBAction) clearLifeTotal:(id)sender;
- (IBAction) fbButton: (id)sender;
- (IBAction) sliderChanged:(id)sender;
- (IBAction) pennySliderChanged:(id)sender;
- (float) dollaInt;
- (int) mainInt;

@property (nonatomic, assign) int mainInt;
@property (nonatomic, assign) float dollaInt;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *dollas;
@property (nonatomic, retain) IBOutlet UILabel *hourlyRate;
@property (nonatomic, strong) IBOutlet UIButton *start;
@property (nonatomic, strong) IBOutlet UIButton *stop;
@property (nonatomic, strong) IBOutlet UIButton *clearLifeTotal;
@property (nonatomic, strong) IBOutlet UIButton *fbButton;
@end