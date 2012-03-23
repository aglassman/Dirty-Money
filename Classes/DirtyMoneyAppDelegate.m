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

@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize facebook;

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Override point for customization after app launch
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
     facebook = [[Facebook alloc] initWithAppId:@"196422827058096"
                                    andDelegate:self];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:
            @"FBExpirationDateKey"];
    }
		
	if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    }
        return YES;
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
    


- (void)dealloc {
    [viewController release];
    [window release];
    //[super dealloc];
}


@end
