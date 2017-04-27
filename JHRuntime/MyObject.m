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

+ (void)initialize
{
    [super initialize];
    
    Class a = self;
    const char *aStr = object_getClassName(a);
    NSLog(@"类方法[self class] - %s", aStr);
    
    Class b = [MyObject class];
    const char *bStr = object_getClassName(b);
    NSLog(@"类方法[MyObject class] - %s", bStr);
    
    Class c = [self class];
    const char *cStr = object_getClassName(c);
    NSLog(@"类方法[self class] - %s", cStr);
    
    Class d = [super class];
    const char *dStr = object_getClassName(d);
    NSLog(@"类方法[super class] - %s", dStr);
    
    Class metaClass = objc_getMetaClass("MyObject");
    const char *metaStr = object_getClassName(metaClass);
    NSLog(@"类方法objc_getMetaClass %p---%s", metaClass,metaStr);
    
    //objc_getClass参数是类名的字符串，返回的就是这个类的类对象；object_getClass参数是id类型，它返回的是这个id的isa指针所指向的Class，如果传参是Class，则返回该Class的metaClass。
    Class currentClass = object_getClass(self);
    const char *objectStr = object_getClassName(currentClass);
    NSLog(@"类方法object_getClass %p---%s", currentClass,objectStr);
    
    Class selfClass = object_getClass([self class]);
    const char *selfClassStr = object_getClassName(selfClass);
    NSLog(@"类方法bject_getClass([self class]) %p---%s", selfClass,selfClassStr);
    
    Class curClass = objc_getClass("MyObject");
    const char *objcStr = object_getClassName(curClass);
    NSLog(@"类方法objc_getClass %p---%s", curClass,objcStr);

}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        Class a = self;
        const char *aStr = object_getClassName(a);
        NSLog(@"实例方法[self class] - %s", aStr);
        
        Class b = [MyObject class];
        const char *bStr = object_getClassName(b);
        NSLog(@"实例方法[MyObject class] - %s", bStr);
        
        Class c = [self class];
        const char *cStr = object_getClassName(c);
        NSLog(@"实例方法[self class] - %s", cStr);
        
        Class d = [super class];
        const char *dStr = object_getClassName(d);
        NSLog(@"实例方法[super class] - %s", dStr);
        
        Class currentClass = object_getClass(self);
        const char *objectStr = object_getClassName(currentClass);
        NSLog(@"实例方法object_getClass %p---%s", currentClass,objectStr);
        
        Class selfClass = object_getClass([self class]);
        const char *selfClassStr = object_getClassName(selfClass);
        NSLog(@"实例方法bject_getClass([self class]) %p---%s", selfClass,selfClassStr);
        
        Class curClass = objc_getClass("MyObject");
        const char *objcStr = object_getClassName(curClass);
        NSLog(@"实例方法objc_getClass %p---%s", curClass,objcStr);
        
        Class metaClass = objc_getMetaClass("MyObject");
        const char *metaStr = object_getClassName(metaClass);
        NSLog(@"实例方法objc_getMetaClass %p---%s", metaClass,metaStr);
        
        
    }
    return self;
}




@end
