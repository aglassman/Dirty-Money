//
//  DirtyMoneyViewController.m
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "DirtyMoneyViewController.h"

@implementation DirtyMoneyViewController
@synthesize label;
@synthesize dollas;
@synthesize rate2;
@synthesize hourlyRate;
	
	
-(IBAction)start:(id)sender {
	
	randomMain = [NSTimer scheduledTimerWithTimeInterval:(1.0/1.0) target:self selector:@selector(randomMainVoid) userInfo:nil repeats:YES];
	
	start = (UIButton *) sender;
	
	bank.enabled = NO;
	bank.alpha = .05f;
	
	stop.enabled = YES;
	stop.alpha = 1.0f;
	
	start.enabled = NO;
	start.alpha = .05f;
	
	copy.enabled = NO;
	copy.alpha = .05f;
	
}


- (IBAction)bank:(id)sender {
	
	bank = (UIButton *) sender;
	floatTot = [dollas.text floatValue] + floatTot;
	bankTot.text = [NSString stringWithFormat:@"%02.2f", floatTot];
	
	stop.enabled = NO;
	stop.alpha = .05f;
	
	start.enabled = YES;
	start.alpha = 1.0f;
	
	bank.enabled = NO;
	bank.alpha = .05f;
	
	copy.enabled = YES;
	copy.alpha = 1.0f;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:bankTot.text forKey:@"bankKey"];
	[defaults setFloat:floatTot forKey:@"floatKey"];
	[defaults setInteger:dollaInt forKey:@"intKey"];
	[defaults synchronize];
	
}

- (IBAction)copy:(id)sender
{
	copy = (UIButton *) sender;
	
	[hourlyRate setText:[rate2 text]];
	
	rate = [hourlyRate.text floatValue];
	
	stop.enabled = NO;
	stop.alpha = .05f;
	
	start.enabled = YES;
	start.alpha = 1.0f;
	
	bank.enabled = YES;
	bank.alpha = 1.0f;
	
	copy.enabled = YES;
	copy.alpha = 1.0f;
	
	NSUserDefaults *defaultsRate = [NSUserDefaults standardUserDefaults];
	[defaultsRate setObject:hourlyRate.text forKey:@"rateKey"];
	[defaultsRate setInteger:rate forKey:@"rateInt"];
	[defaultsRate synchronize];
	
}


-(void)randomMainVoid {
	
	mainInt += 1;
	label.text = [NSString stringWithFormat:@"%d", mainInt];
	
	dollaInt = (mainInt * rate / 36) / 100;
	dollas.text = [NSString stringWithFormat:@"%02.2f", dollaInt];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)rate2 {
    if (1 == 1) {
        [rate2 resignFirstResponder];
    }
    return YES;
}	

- (IBAction)stop:(id)sender {
	
	[randomMain invalidate];
	
	stop = (UIButton *) sender;
	
	stop.enabled = NO;
	stop.alpha = .05f;
	
	start.enabled = YES;
	start.alpha = 1.0f;
	
	bank.enabled = YES;
	bank.alpha = 1.0f;
	
	copy.enabled = YES;
	copy.alpha = 1.0f;
    
    
	
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
}

- (IBAction)clearCount:(id)sender {
	
	mainInt = 0;
	dollas.text = [NSString stringWithFormat:@"%02.2f", 0];
}

- (IBAction)clearBank:(id)sender {
	
	dollaInt = 0;
	bankTot.text = [NSString stringWithFormat:@"%02.2f", 0];
	floatTot = 0;
}

					 
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	bankTot.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bankKey"];
	floatTot = [[NSUserDefaults standardUserDefaults] floatForKey:@"floatKey"];
	dollaInt = [[NSUserDefaults standardUserDefaults] integerForKey:@"intKey"];
	
	hourlyRate.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"rateKey"];
	rate = [[NSUserDefaults standardUserDefaults] integerForKey:@"rateInt"];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Text Fields

@end
