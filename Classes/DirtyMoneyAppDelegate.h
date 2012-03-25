//
//  DirtyMoneyAppDelegate.h
//  DirtyMoney
//
//  Created by Kyle Luchinski on 1/20/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"


@class DirtyMoneyViewController;

@interface DirtyMoneyAppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate> {
    UIWindow *window;
    DirtyMoneyViewController *viewController;
    Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DirtyMoneyViewController *viewController;
@property (nonatomic, retain) Facebook *facebook;

@end

