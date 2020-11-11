//
//  AppDelegate.m
//  RACPlayground
//
//  Created by jhmac on 2020/10/31.
//

#import "AppDelegate.h"
#import <XFLegoVIPER/LEMVVMModuleHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // style the navigation bar
    if (@available(iOS 13.0, *)) {

    } else {
        
    }
    UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // make the status bar white
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 配置乐高框架 // 使有默认配置
    [[[XFLegoConfig defaultConfig]
                    enableLog]                                           // 允许打印log
                    addComponentHanderPlug:[LEMVVMModuleHandler class]]; // 添加扩展MVVM模块组件处理器（用来处理MVVM模块组件）
    
    // 注册APP的所有URL
    [XFURLRoute initURLGroup:@[
                                 @"rac://Login", // 测试跳转
                                 @"rac://RACRegister", //
                                 @"rac://Home"
                                 ]];
    
    // 根据URL显示组件(注意：这里一定要可以用使用self.window，不然当前宏不可用！)
//    XF_ShowURLComponent2Window_Fast(@"rac://Login")
    //行为参数nav，目前仅支持一个。nav=UI 告知下一个页面需要导航栏
    //添加自定义导航栏：导航控制器的前缀后边的内容必须是NavigationController
    XF_ShowURLComponent2Window_(@"rac://Login?nav=Lego", {
        //拿到界面对象，
        UIViewController *nextVC =  nextInterface;
        nextVC.title = @"登录";
        // 自定义导航栏 Lego前缀，集成系统导航栏，这时就可以在URl上nav=Lego即可。
        
        // 配置导航栏
//        UINavigationController *navigation = nextVC.navigationController;
//        navigation.navigationBar.barTintColor = [UIColor colorWithRed:217/255.0 green:108/255.0 blue:0/255.0 alpha:1];
//        [navigation.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    })
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
