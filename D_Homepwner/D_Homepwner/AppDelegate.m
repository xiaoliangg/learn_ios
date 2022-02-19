//
//  AppDelegate.m
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
/**
 一、启动应用顺序：
 1.application:didFinishLaunchingWithOptions:
 2.scene:willConnectToSession:options:
 3.sceneWillEnterForeground:
 4.sceneDidBecomeActive:
 二、按下主屏幕按钮
 1.sceneWillResignActive:
 2.sceneDidEnterBackground:
 三、从后台回到前台
 1.sceneWillEnterForeground:
 2.sceneDidBecomeActive:
 四、手动杀死应用
 1.sceneDidDisconnect:
 2.application:didDiscardSceneSessions:

 */

/**
 从未运行状态进入激活状态
 可能的动作:启动应用
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
