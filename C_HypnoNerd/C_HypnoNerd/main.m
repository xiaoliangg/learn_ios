//
//  main.m
//  C_HypnoNerd
//
//  Created by yl on 2022/1/31.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 UIApplicationMain函数作用:
 1、创建 UIApplication 对象，该对象用来维护运行循环
 2、创建并设置 UIApplication 对象的 delegate
 3、启动运行循环并开始接收事件前，UIApplication 对象会向其delegate发送 application:didFinishLaunchingWithOptions 的消息，使应用能有机会完成相应的初始化工作
 */
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
