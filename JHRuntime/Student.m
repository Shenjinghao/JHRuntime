//
//  Student.m
//  JHRuntime
//
//  Created by Shenjinghao on 2017/4/17.
//  Copyright © 2017年 SJH. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@interface Student ()
{
    @private
    NSInteger age;
}


@end

@implementation Student

#pragma mark 动态解析类方法，注意：动态方法需要绑定动态方法的实现，类方法需要绑定类方法的实现
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(learnClass:)) {
        class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(myClassMethod:)), "v@:");
        return YES;
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(goToSchool:)) {
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(myInstanceMethod:)), "v@:");
        return YES;
    }
    return [class_getSuperclass(self) resolveInstanceMethod:sel];
}


+ (void)myClassMethod:(NSString *)string
{
    NSLog(@"MyClassMethod = %@",string);
}

- (void)myInstanceMethod:(NSString *)string
{
    NSLog(@"MyInstanceMethod = %@",string);
}

- (NSString *)description
{
    NSLog(@"current pointer = %p", self);
    NSLog(@"age pointer = %p", &age);
    return [NSString stringWithFormat:@"age = %ld", (long)age];
}


@end
