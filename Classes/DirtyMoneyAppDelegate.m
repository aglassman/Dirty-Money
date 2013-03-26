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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[DirtyMoneyViewController alloc] initWithNibName:@"DirtyMoneyViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbSessionInvalidated {
    
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt {
    
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
}

-(void)applicationWillResignActive:(UIApplication *)application {
    
    closeTime = [[NSDate date]retain];

    NSUserDefaults *defaultsCloseTime;
	[defaultsCloseTime setInteger:closeTime forKey:@"closeTimeKey"];
	[defaultsCloseTime synchronize];
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
    
    closeTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"closeTimeKey"];
 
    timeInterval = [closeTime timeIntervalSinceNow] * -100;
    
}

- (NSTimeInterval)timeInterval {
    return timeInterval;
}


- (void)dealloc {
    [viewController release];
    [rootController release];
    [window release];
    [super dealloc];
}


@end