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
@synthesize rootController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
   [window addSubview:viewController.view];
   [window addSubview:rootController.view];
   [window makeKeyAndVisible];
    
   [window setRootViewController:rootController];
    
}


- (BOOL)application:(UIApplication *)application handleopenURL:(NSURL *)url {
    
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    
}


- (void)fbDidLogout {
    
}

- (void)fbSessionInvalidated {
    
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt {
    
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
}
    

- (void)dealloc {
    [viewController release];
    [rootController release];
    [window release];
    [super dealloc];
}


@end