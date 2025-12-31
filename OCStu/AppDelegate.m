//
//  AppDelegate.m
//  OCStu
//
//  Created by Derek on 2025/12/30.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 应用启动后的自定义配置入口点
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // 当创建新的场景会话时调用
    // 使用此方法选择用于创建新场景的配置
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // 当用户丢弃场景会话时调用
    // 如果在应用未运行时有会话被丢弃，此方法将在 application:didFinishLaunchingWithOptions 后不久调用
    // 使用此方法释放被丢弃场景的专用资源，因为这些场景不会再返回
}


@end
