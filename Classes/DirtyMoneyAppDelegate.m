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
    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
    
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Override point for customization after app launch
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
     facebook = [[Facebook alloc] initWithAppId:@"196422827058096"
                                    andDelegate:self];
    
    
    NSUserDefaults *fbDefaults = [NSUserDefaults standardUserDefaults];
    if ([fbDefaults objectForKey:@"FBAccessTokenKey"]
        && [fbDefaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [fbDefaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [fbDefaults objectForKey:
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
    [window release];
    [super dealloc];
}


@end
