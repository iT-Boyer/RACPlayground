//
//  AppDelegate.m
//  RACPlayground
//
//  Created by jhmac on 2020/10/31.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // style the navigation bar
    if (@available(iOS 13.0, *)) {

    } else {
        
        UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
        [[UINavigationBar appearance] setBarTintColor:navColor];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        // make the status bar white
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        [self.window setBackgroundColor:[UIColor whiteColor]];
//
//        ViewController *con = [[ViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
//        [self.window setRootViewController:nav];
//        [self.window makeKeyAndVisible];
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
