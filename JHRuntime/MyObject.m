//
//  MyObject.m
//  HelloWord
//
//  Created by Shenjinghao on 2017/4/11.
//  Copyright © 2017年 myProject. All rights reserved.
//

#import "MyObject.h"
#import <objc/runtime.h>

@interface MyObject ()
{
    NSString *stringIvar;
}


@end

@implementation MyObject


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

+ (void)initialize
{
    NSLog(@"%@", NSStringFromClass([MyObject class]));
    
}



@end
