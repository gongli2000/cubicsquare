//
//  CameraAppDelegate.m
//  Camera
//
//  Created by James Eclipse on 7/30/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "CameraAppDelegate.h"
#import "MainViewController.h"

@implementation CameraAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
