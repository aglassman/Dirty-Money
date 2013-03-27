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

	float dollaFloat, rate, floatTot, slideValue, pennySlideValue;
	IBOutlet UILabel *lifeTotal;
	IBOutlet UILabel *label;
	IBOutlet UILabel *dollas;
	NSTimer *randomMain;
	NSNumber *total;
	IBOutlet UILabel * hourlyRate;
    Facebook *facebook;
    NSArray *permissions;
    UISlider *slider, *pennySlider;
    NSUserDefaults *defaultsRate;
    NSDate *dateStart;
    NSTimeInterval interval;
}

- (float) dollaFloat;
- (IBAction) start:(id)sender;
- (IBAction) stop:(id)sender;
- (IBAction) clearLifeTotal:(id)sender;
- (IBAction) fbButton: (id)sender;
- (IBAction) sliderChanged:(id)sender;
- (IBAction) pennySliderChanged:(id)sender;

@property (nonatomic, assign) float dollaFloat;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *dollas;
@property (nonatomic, retain) IBOutlet UILabel *hourlyRate;
@property (nonatomic, strong) IBOutlet UIButton *start;
@property (nonatomic, strong) IBOutlet UIButton *stop;
@property (nonatomic, strong) IBOutlet UIButton *clearLifeTotal;
@property (nonatomic, strong) IBOutlet UIButton *fbButton;
@end