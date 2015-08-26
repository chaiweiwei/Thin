//
//  AppDelegate.m
//  Thin
//
//  Created by 求攻略 on 15/8/23.
//  Copyright (c) 2015年 求攻略. All rights reserved.
//

#import "AppDelegate.h"
#import <sqlite3.h>

@interface AppDelegate ()<UIAlertViewDelegate>
{
    sqlite3 *database;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *path = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    
    NSString *dbFile = [path.path stringByAppendingPathComponent:@"thin.db"];
    
    if(![fileManager fileExistsAtPath:dbFile]) {
        NSString *fromPath = [[NSBundle mainBundle] pathForResource:@"thin.db" ofType:nil];
        
        [fileManager copyItemAtPath:fromPath toPath:dbFile error:nil];
    }
    
    if(sqlite3_open([dbFile UTF8String], &database) != SQLITE_OK) {
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
    
    sqlite3_close(database);
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor redColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:19.0f]
                                                           }];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor greenColor]]; //字体的前景色   barTintColor是背景颜色
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}
- (void)applicationDidBecomeActive:(UIApplication *)application {



}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kQGLRightPassword];

}

@end
