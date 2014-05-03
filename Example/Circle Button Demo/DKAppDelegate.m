//
//  DKAppDelegate.m
//  Circle Button Demo
//
//  Created by Dmitry Klimkin on 3/5/14.
//  Copyright (c) 2014 Dmitry Klimkin. All rights reserved.
//

#import "DKAppDelegate.h"
#import "DKCircleButton.h"

@interface DKAppDelegate () {
    BOOL buttonState;
    DKCircleButton *button1;
    DKCircleButton *button2;
}

@end

@implementation DKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1];
    
    UIViewController *viewController = [UIViewController new];
    
    viewController.view.backgroundColor = [UIColor colorWithRed:0.29 green:0.59 blue:0.81 alpha:1];
    
    button1 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    button1.center = CGPointMake(160, 200);
    button1.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
    [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];

    [button1 addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];

    [viewController.view addSubview:button1];

    button2 = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    
    button2.center = CGPointMake(160, 350);
    button2.titleLabel.font = [UIFont systemFontOfSize:22];
    button2.animateTap = NO;
    
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
    
    [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
    [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
    [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
    
    [button2 addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];
    
    [viewController.view addSubview:button2];
    
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tapOnButton {
    if (buttonState) {
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
        [button1 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];
        
        [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateSelected];
        [button2 setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateHighlighted];

    } else {
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateSelected];
        [button1 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateHighlighted];
        
        [button2 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
        [button2 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateSelected];
        [button2 setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateHighlighted];
    }
    
    buttonState = !buttonState;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
