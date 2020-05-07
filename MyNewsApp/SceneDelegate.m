#import "SceneDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "MyRecommendViewController.h"
#import "MyMineViewController.h"
#import <execinfo.h>
#import "GTNotification.h"

@interface SceneDelegate ()<UITabBarControllerDelegate>

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    UITabBarController *tabbarController = [[UITabBarController alloc] init];

    GTNewsViewController *newsViewController = [[GTNewsViewController alloc]initWithTitle:@"首页"];

    //UIViewController *controller1 = [[UIViewController alloc] init];
    //controller1.view.backgroundColor = [UIColor redColor];
    newsViewController.tabBarItem.title = @"新闻";
    newsViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
    newsViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    //navigationController.navigationItem.title = @"新闻首页";

    GTVideoViewController *controller2 = [[GTVideoViewController alloc] init];

    MyRecommendViewController *controller3 = [[MyRecommendViewController alloc] init];

    MyMineViewController *mineViewController = [[MyMineViewController alloc] init];
    mineViewController.view.backgroundColor = [UIColor yellowColor];
    mineViewController.tabBarItem.title = @"我的";
    mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
    mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];

    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:tabbarController];

    [tabbarController setViewControllers:@[newsViewController, controller2, controller3, mineViewController]];

    tabbarController.delegate = self;

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[GTNotification notificationManager] checkNotificationAuthorization];
    

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"didSelectViewController");
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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


@end
