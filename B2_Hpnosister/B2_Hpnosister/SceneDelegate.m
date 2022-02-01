//
//  SceneDelegate.m
//  B2_Hpnosister
//
//  Created by yl on 2022/2/1.
//

#import "SceneDelegate.h"
#import "BNRHypnosisView.h"

@interface SceneDelegate ()
@property (strong,nonatomic) BNRHypnosisView *bnrHypnosisView;
@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    CGRect sceneRect =  self.window.bounds;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:sceneRect];
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:sceneRect];
    [scrollView addSubview:hypnosisView];
    
    CGRect bigRect = sceneRect;
    bigRect.size.width *= 2.0;
    bigRect.size.height *= 2.0;
    scrollView.contentSize = bigRect.size;
    [scrollView setPagingEnabled:NO];

    // 此处尺寸不设置或者设置有问题，都会导致不会发送 viewForZoomingInScrollView 消息
    // 参考:
    scrollView.minimumZoomScale = 2.0;
    scrollView.maximumZoomScale = 10.0;
    //
    scrollView.delegate = self;
    self.bnrHypnosisView = hypnosisView;
    
    [self.window addSubview:scrollView];
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"size is:%@",scrollView);
    CGRect rect = self.bnrHypnosisView.frame;
    rect.size = scrollView.frame.size;
    rect.origin = scrollView.frame.origin;
    [self.bnrHypnosisView setFrame:rect];
    return self.bnrHypnosisView;
}
@end
