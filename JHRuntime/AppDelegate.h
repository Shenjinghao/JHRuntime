//
//  AppDelegate.h
//  JHRuntime
//
//  Created by Shenjinghao on 2017/4/14.
//  Copyright © 2017年 SJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

