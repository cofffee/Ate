//
//  AppDelegate.m
//  Ate
//
//  Created by Kevin Remigio on 2/10/16.
//  Copyright © 2016 Kevin Remigio. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WeekViewController.h"
#import "MonthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SystemSoundID SoundID;
    NSString *soundFile = [[NSBundle mainBundle] pathForResource:@"ohyeah" ofType:@"m4a"];
    NSLog(@"%@", soundFile);
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &SoundID);
    AudioServicesPlaySystemSound(SoundID);
    
    //set up window
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    //Acesses whether or not the user is logged in
    BOOL loggedIn = NO;
    NSString *username;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults floatForKey:@"loggedin"]){
        username = [defaults objectForKey:@"username"];

        loggedIn = YES;
    }
    
    //instantiate storyboard from Main storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Load log in view if not logged in
//    if (!loggedIn) {
//        UIViewController *pv = [storyboard instantiateViewControllerWithIdentifier:@"premain"];
//        self.window.rootViewController = pv;
//        [self.window makeKeyAndVisible];
//    }
//    //load front of the app if logged in
//    else {
        //Set up first view
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    UINavigationController *vcNavCtrl = [[UINavigationController alloc] initWithRootViewController:vc];
    
    //Then second (weeks) view
    WeekViewController *wvc = [storyboard instantiateViewControllerWithIdentifier:@"weekview"];
    wvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    UINavigationController *wvcNavCtrl = [[UINavigationController alloc] initWithRootViewController:wvc];
    
    //Then months view
    MonthViewController *mvc = [storyboard instantiateViewControllerWithIdentifier:@"monthview"];
    mvc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:0];
    UINavigationController *mvcNavCtrl = [[UINavigationController alloc] initWithRootViewController:mvc];
    
    // determine the initial view controller here and instantiate it with [storyboard instantiateViewControllerWithIdentifier:<storyboard id>];

    //Set up tab controller
    UITabBarController *tabCtrl = [[UITabBarController alloc] init];
    self.window.rootViewController = tabCtrl;
    tabCtrl.viewControllers = @[vcNavCtrl, wvcNavCtrl, mvcNavCtrl];
    
    //Show the window
    [self.window makeKeyAndVisible];
//    }
//    [self presentViewController:navCtrl animated:YES completion:nil];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}



@end
