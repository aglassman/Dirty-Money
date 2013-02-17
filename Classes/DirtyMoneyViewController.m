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

@interface DirtyMoneyViewController()
@end
@implementation DirtyMoneyViewController
@synthesize label;
@synthesize dollas;
@synthesize hourlyRate;
@synthesize start, stop, fbButton, clearLifeTotal;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	lifeTotal.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bankKey"];
	floatTot = [[NSUserDefaults standardUserDefaults] floatForKey:@"floatKey"];
	dollaInt = [[NSUserDefaults standardUserDefaults] integerForKey:@"intKey"];
	hourlyRate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"rateKey"];
	rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rateInt"];
    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
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
    
    float slideValue = (float)(slider.value);
    hourlyRate.text =[[NSString alloc] initWithFormat:@"%02.2f", slideValue];
    
    //Confirm
    rate = [hourlyRate.text floatValue];
    
	stop.hidden = YES;
	start.hidden = NO;
	fbButton.hidden = YES;
    clearLifeTotal.hidden = YES;
    
	NSUserDefaults *defaultsRate = [NSUserDefaults standardUserDefaults];
	[defaultsRate setObject:hourlyRate.text forKey:@"rateKey"];
	[defaultsRate setInteger:rate forKey:@"rateInt"];
	[defaultsRate synchronize];
}
	
-(IBAction)start:(id)sender {
	
	start = (UIButton *) sender;
	
	stop.hidden = NO;
	start.hidden = YES;
    fbButton.hidden = YES;
    clearLifeTotal.hidden = YES;
    slider.userInteractionEnabled = NO;
    
    randomMain = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(randomMainVoid) userInfo:nil repeats:YES];
	
}

-(void)randomMainVoid {
	
	mainInt += 1;
	label.text = [NSString stringWithFormat:@"%d", mainInt];
	
	dollaInt = (mainInt * rate / 36) / 100;
	dollas.text = [NSString stringWithFormat:@"%02.2f", dollaInt];
}

- (IBAction)stop:(id)sender {
    
	
	[randomMain invalidate];
	
	stop = (UIButton *) sender;
    
    stop.hidden = YES;
	start.hidden = NO;
    fbButton.hidden = NO;
    clearLifeTotal.hidden = NO;
    slider.userInteractionEnabled = YES;
    
	
	if (dollaInt >= 0.01 && dollaInt < 1.5) {
		NSString *message = [[NSString alloc] initWithFormat:
						 @"Only $%@! That can't be all",dollas.text];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
						  @"C'mon!"
						  
													message:message
												   delegate:nil
										  cancelButtonTitle:@"YES!"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	[message release];
        
    }
	
	
	if (dollaInt >= 1.5 && dollaInt < 2) {
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
	
	if (dollaInt >= 2) {
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
    [defaults setInteger:dollaInt forKey:@"intKey"];
    [defaults synchronize];
    
    mainInt = 0;
    
    //dollas.text = [NSString stringWithFormat:@"%02.2f", 0.00];
    
}


- (IBAction)fbButton:(id)sender {
    
    
    //Login to FB
    
    facebook = [[Facebook alloc] initWithAppId:@"196422827058096" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes", 
                                @"read_stream",
                                @"publish_stream",
                                nil];
        [facebook authorize:permissions];
        [permissions release];
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
                                   @"Dirty Money is an app that calcualtes how much money you make while rockin' a deuce at work.  What could be more glorious than that?  See how much you can make!", @"description",
                                   @"http://www.facebook.com/pages/Dirty-Money/204640386301048", @"link",
                                   @"http://farm8.staticflickr.com/7185/6999841878_e66a8e00fc_t.jpg", @"picture",
                                   actionLinksStr, @"actions",
                                   nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
    
    
}

- (IBAction)clearLifeTotal:(id)sender {
	
	dollaInt = 0;
	lifeTotal.text = [NSString stringWithFormat:@"%02.2d", 0];
	floatTot = 0;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [super dealloc];
    [hourlyRate release];
}

#pragma mark -
#pragma mark Text Fields

@end
