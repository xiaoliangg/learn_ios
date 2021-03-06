//
//  SceneDelegate.m
//  D_Homepwner
//
//  Created by yl on 2022/2/1.
//

#import "SceneDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

/**
 从未运行状态进入激活状态
 可能的动作:启动应用
 */
- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    // 创建BNRItemsViewController对象
    BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
    // 创建UINavigationController对象
    // 该对象的栈只包含itemsViewController
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    // 将UINavigationController对象设置为UIWindow对象的根视图控制器，
    // 这样就可以将UINavigationController对象的视图添加到屏幕上
    [self.window setRootViewController:navController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

/**
 激活状态进入未激活状态
 可能点动作:被系统事件打断，如：短消息、推送、来电、闹钟
 */
- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

/**
 挂起状态—>激活状态
 可能的动作：切换回本应用,且系统没有终止该应用
 */
- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

/**
 激活状态—>后台运行状态。后台运行约10s左右，进入挂起状态
 可能的动作：home键、切换到其他应用
 */
- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if(success){
        NSLog(@"Saved all of the BNRItems");
    }else{
        NSLog(@"Could not save any of the BNRItems");
    }
}


@end
