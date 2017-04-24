//
//  Student.m
//  JHRuntime
//
//  Created by Shenjinghao on 2017/4/17.
//  Copyright © 2017年 SJH. All rights reserved.
//

#import "Student.h"

@interface Student ()
{
    @private
    NSInteger age;
}


@end

@implementation Student

- (NSString *)description
{
    NSLog(@"current pointer = %p", self);
    NSLog(@"age pointer = %p", &age);
    return [NSString stringWithFormat:@"age = %ld", (long)age];
}


@end
