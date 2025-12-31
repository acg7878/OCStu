//
//  SceneDelegate.m
//  OCStu
//
//  Created by Derek on 2025/12/30.
//

#import "SceneDelegate.h"
#import "HomeViewController.h"
#import "MeViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // 使用此方法可选地配置并将 UIWindow `window` 附加到提供的 UIWindowScene `scene`
    // 如果使用 storyboard，`window` 属性将自动初始化并附加到场景
    // 此代理方法不意味着连接的场景或会话是新的（请参阅 `application:configurationForConnectingSceneSession`）
    
    
    if(![scene isKindOfClass:[UIWindowScene class]]) {return;}
    UIWindowScene *windowScene = (UIWindowScene*)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene]; // 创建Window，应用的顶层容器，关联到场景
    
    // 创建页面控制器
    HomeViewController* homeVC = [[HomeViewController alloc] init];
    MeViewController* meVC = [[MeViewController alloc] init];
    
    // 创建导航控制器，包装页面控制器
    UINavigationController* homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController* meNav = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    // 配置 Tab 图标与标题
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    meNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage systemImageNamed:@"person"] selectedImage:[UIImage systemImageNamed:@"person.fill"]];
    
    // 创建底栏控制器
    UITabBarController *tabBar = [[UITabBarController alloc] init];
        tabBar.viewControllers = @[homeNav, meNav];

    self.window.rootViewController = tabBar;
    // 让 window 成为关键 window 并显示（接收用户交互）
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // 当场景被系统释放时调用
    // 这发生在场景进入后台后不久，或当其会话被丢弃时
    // 释放与此场景关联的任何可以在下次场景连接时重新创建的资源
    // 场景可能稍后重新连接，因为其会话不一定被丢弃（请参阅 `application:didDiscardSceneSessions`）
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // 当场景从非活跃状态转为活跃状态时调用
    // 使用此方法重启在场景非活跃时暂停（或尚未开始）的任何任务
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // 当场景将从活跃状态转为非活跃状态时调用
    // 这可能由于临时中断（例如来电）而发生
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // 当场景从后台过渡到前台时调用
    // 使用此方法撤销进入后台时所做的更改
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // 当场景从前台过渡到后台时调用
    // 使用此方法保存数据，释放共享资源，并存储足够的场景特定状态信息
    // 以便将场景恢复到当前状态
}


@end
