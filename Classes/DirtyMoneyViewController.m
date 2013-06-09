//
//  DirtyMoneyViewController.m
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "DirtyMoneyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Glossy.h"
#import "DirtyMoneyAppDelegate.h"
#import <iAd/iAd.h>


@interface DirtyMoneyViewController()
@end
@implementation DirtyMoneyViewController
@synthesize label;
@synthesize dollas;
@synthesize hourlyRate;
@synthesize start, stop, fbButton, clearLifeTotal;
@synthesize dollaFloat;
@synthesize contentView = _contentView;
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;

-(void)viewDidLoad  {
    
    [super viewDidLoad];
    [self createAdBannerView];
    
    DirtyMoneyAppDelegate *delegate = (DirtyMoneyAppDelegate *)[UIApplication sharedApplication].delegate;
    
    facebook = [[Facebook alloc] initWithAppId:@"196422827058096" andDelegate:delegate];
    
    permissions = [[NSArray alloc] initWithObjects:@"user_likes", @"read_stream",@"publish_stream", nil];
    
    lifeTotal.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bankKey"];
	floatTot = [[NSUserDefaults standardUserDefaults] floatForKey:@"floatKey"];
	dollaFloat = [[NSUserDefaults standardUserDefaults] integerForKey:@"intKey"];
	hourlyRate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"rateKey"];
	rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rateInt"];
    slider.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"rateInt"];
    pennySlider.value = [[NSUserDefaults standardUserDefaults] floatForKey:@"pennyRate"];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //[self refresh];
    [self fixupAdView:[UIDevice currentDevice].orientation];
    
    NSArray *buttons = [NSArray arrayWithObjects: self.start, self.stop, self.fbButton, self.clearLifeTotal,nil];
    
    for(UIButton *btn in buttons)
    {
        // Set the button Text Color
        [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // Set default backgrond color
        [btn setBackgroundColor:[UIColor blackColor]];
        
        // Add Custom Font
        [[btn titleLabel] setFont:[UIFont fontWithName:@"BodoniSvtyTwoSCITCTT-Book" size:18.0f]];
        
        // Draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                              (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                              nil];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [btn layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
        // Apply a 1 pixel, black border around Buy Button
        [btnLayer setBorderWidth:1.0f];
        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
        // Make glossy
        //[btn makeGlossy];
    }
    
    stop.hidden = YES;
    fbButton.hidden = YES;
    
}

-(IBAction)sliderChanged:(id)sender {
    slider = (UISlider *)sender;
    
    slideValue = (int)(slider.value);
    
    hourlyRate.text =[[NSString alloc] initWithFormat:@"%02.2f", slideValue+pennySlideValue];
    
    //Confirm
    rate = [hourlyRate.text floatValue];
    
	stop.hidden = YES;
	start.hidden = NO;
	fbButton.hidden = YES;
    clearLifeTotal.hidden = YES;
    
	defaultsRate = [NSUserDefaults standardUserDefaults];
	[defaultsRate setObject:hourlyRate.text forKey:@"rateKey"];
	[defaultsRate setInteger:rate forKey:@"rateInt"];
	[defaultsRate synchronize];
}

-(IBAction) pennySliderChanged:(id)sender {
    
    hourlyRate.text =[[NSString alloc] initWithFormat:@"%0.2f", slideValue+pennySlideValue];
    
    pennySlideValue = (float)(pennySlider.value);
    
    rate = [hourlyRate.text floatValue];
    
    stop.hidden = YES;
	start.hidden = NO;
	fbButton.hidden = YES;
    clearLifeTotal.hidden = YES;
    
    defaultsRate = [NSUserDefaults standardUserDefaults];
    [defaultsRate setObject:hourlyRate.text forKey:@"rateKey"];
    [defaultsRate setFloat:pennySlider.value forKey:@"pennyRate"];
    [defaultsRate synchronize];

}

-(IBAction)start:(id)sender {
	
	start = (UIButton *) sender;
	
    //message to set rate
    if (rate == 0.00) {
        
        UIAlertView *instruct = [[UIAlertView alloc] initWithTitle:
                                 @"Use the sliders to set your rate"
                                 
                                                           message:nil
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [instruct show];
        [instruct release];
        [instruct release];
    }
    else {
    
	stop.hidden = NO;
	start.hidden = YES;
    fbButton.hidden = YES;
    clearLifeTotal.hidden = YES;
    slider.userInteractionEnabled = NO;
    pennySlider.userInteractionEnabled = NO;
    
    randomMain = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(randomMainVoid) userInfo:nil repeats:YES];
    
    dateStart = [[NSDate date]retain];
    }
    
}

-(void)randomMainVoid {
    
    interval = round([dateStart timeIntervalSinceNow]) *-1;
    
	label.text = [NSString stringWithFormat:@"%g", interval];
    
	dollaFloat = (interval * rate / 36) / 100;
	dollas.text = [NSString stringWithFormat:@"%02.2f", dollaFloat];
}

-(IBAction)stop:(id)sender {
	
	[randomMain invalidate];
    
	stop = (UIButton *) sender;
    
    stop.hidden = YES;
	start.hidden = NO;
    fbButton.hidden = NO;
    clearLifeTotal.hidden = NO;
    slider.userInteractionEnabled = YES;
    pennySlider.userInteractionEnabled = YES;
    
	
	if (dollaFloat >= 0.01 && dollaFloat < 1.5) {
		NSString *message = [[NSString alloc] initWithFormat:
						 @"Only $%@! That can't be all",dollas.text];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
						  @"C'mon!"
						  
													message:message
												   delegate:self
										  cancelButtonTitle:@"Close"
										  otherButtonTitles:@"Post to FaceBook",nil];
	[alert show];
	[alert release];
	[message release];
        
        
    }
	
	
	if (dollaFloat >= 1.5 && dollaFloat < 2) {
		NSString *message = [[NSString alloc] initWithFormat:
							 @"Somone just paid you $%@ for that.. WIN", dollas.text];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
							  @"NICE"
							  
														message:message
													   delegate:nil
											  cancelButtonTitle:@"YES!"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[message release];
        
    }
	
	if (dollaFloat >= 2) {
		NSString *message = [[NSString alloc] initWithFormat:
							 @"You just stuck it to the MAN for $%@!!", dollas.text];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
							  @"GLORY!!"
							  
														message:message
													   delegate:nil
											  cancelButtonTitle:@"YES!"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[message release];
        
    }
    
    //Bank total
    
    floatTot = [dollas.text floatValue] + floatTot;
    lifeTotal.text = [NSString stringWithFormat:@"%02.2f", floatTot];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lifeTotal.text forKey:@"bankKey"];
    [defaults setFloat:floatTot forKey:@"floatKey"];
    [defaults setInteger:dollaFloat forKey:@"intKey"];
    [defaults synchronize];
}

-(IBAction)fbButton:(id)sender {
    
    if (![facebook isSessionValid]) {
        [facebook authorize:permissions];
        [permissions release];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    //Post to Wall
    
    NSString *poopDollas = [[NSString alloc] initWithFormat:
						 @"I just made $%@ while using the Dirty Money app!",dollas.text];
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    // The action links to be shown with the post in the feed
    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      @"Get Started",@"name",@"http://www.facebook.com/pages/Dirty-Money/204640386301048",@"link", nil], nil];
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    // Dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Dirty Money", @"name",
                                   poopDollas, @"caption",
                                   @"Dirty Money is an app that calculates how much money you make while rockin' a deuce at work.  What could be more glorious than that?  See how much you can make!", @"description",
                                   @"http://www.facebook.com/pages/Dirty-Money/204640386301048", @"link",
                                   @"http://coffeemillfontana.com/Coffee_Mill_Fontana/Blank_files/FBPostIcon.jpg", @"picture",
                                   actionLinksStr, @"actions",
                                   nil];
    
    FBDialog *delegate = (FBDialog *)[UIApplication sharedApplication].delegate;
    
    [facebook dialog:@"feed" andParams:params andDelegate:(id <FBDialogDelegate>)delegate];
}


//Alert View

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/FB buttons
    if (buttonIndex == 1)
    {
        if (![facebook isSessionValid]) {
            [facebook authorize:permissions];
            [permissions release];
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"]
            && [defaults objectForKey:@"FBExpirationDateKey"]) {
            facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        
        //Post to Wall
        
        NSString *poopDollas = [[NSString alloc] initWithFormat:
                                @"I just made $%@ while using the Dirty Money app!",dollas.text];
        
        SBJSON *jsonWriter = [[SBJSON new] autorelease];
        
        // The action links to be shown with the post in the feed
        NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          @"Get Started",@"name",@"http://www.facebook.com/pages/Dirty-Money/204640386301048",@"link", nil], nil];
        NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
        // Dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Dirty Money", @"name",
                                       poopDollas, @"caption",
                                       @"Dirty Money is an app that calculates how much money you make while rockin' a deuce at work.  What could be more glorious than that?  See how much you can make!", @"description",
                                       @"http://www.facebook.com/pages/Dirty-Money/204640386301048", @"link",
                                       @"http://coffeemillfontana.com/Coffee_Mill_Fontana/Blank_files/FBPostIcon.jpg", @"picture",
                                       actionLinksStr, @"actions",
                                       nil];
        
        FBDialog *delegate = (FBDialog *)[UIApplication sharedApplication].delegate;
        
        [facebook dialog:@"feed" andParams:params andDelegate:(id <FBDialogDelegate>)delegate];
        
              }
              else
              {
                  NSLog(@"cancel");
              }
}

-(IBAction)clearLifeTotal:(id)sender {
	
	dollaFloat = 0;
	lifeTotal.text = [NSString stringWithFormat:@"%02.2f", dollaFloat];
	floatTot = 0;
}

- (float) dollaFloat {
       return dollaFloat;
    }

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}

- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc]
                              initWithFrame:CGRectZero] autorelease];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects:
                        ADBannerContentSizeIdentifierLandscape,
                        ADBannerContentSizeIdentifierPortrait, nil]];
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:
             ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:
             ADBannerContentSizeIdentifierPortrait];
        }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0,
                                             -[self getBannerHeight])];
        [_adBannerView setDelegate:self];
        
        [self.view addSubview:_adBannerView];        
    }
}

- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_adBannerView != nil) {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:
             ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:
             ADBannerContentSizeIdentifierPortrait];
        }
        [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 0;
            [_adBannerView setFrame:adBannerViewFrame];
           }
        
        else {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y =
            -[self getBannerHeight:toInterfaceOrientation];
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 0;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;
        }
        [UIView commitAnimations];
    }
}

#pragma mark ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {
        _adBannerViewIsVisible = YES;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_adBannerViewIsVisible)
    {
        _adBannerViewIsVisible = NO;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

-(void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

-(void)dealloc {
    [pennySlider release];
    [super dealloc];
    [hourlyRate release];
    self.contentView = nil;
    self.adBannerView = nil;
}

-(void)viewDidUnload {
    [pennySlider release];
    pennySlider = nil;
    [super viewDidUnload];
}

@end
