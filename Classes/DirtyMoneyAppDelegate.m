//
//  DirtyMoneyAppDelegate.m
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "DirtyMoneyAppDelegate.h"
#import "DirtyMoneyViewController.h"

@implementation DirtyMoneyAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize facebook;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
		
	
}

- (void)application:didFinishLaunchingWithOptions:

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
