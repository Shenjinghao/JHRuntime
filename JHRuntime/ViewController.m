//
//  ViewController.m
//  JHRuntime
//
//  Created by Shenjinghao on 2017/4/14.
//  Copyright © 2017年 SJH. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>
#import "MyObject.h"

@interface ViewController ()
{
    MyObject *obj;
    MyObject *obj2;
}


@property (nonatomic, strong) MyObject *obj;
@property (nonatomic, strong) MyObject *obj2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    obj = [[MyObject alloc] init];
    obj2 = [[MyObject alloc] init];
    
    NSArray* arr = @[obj, obj2];
    
    NSString *string = [self nameWithInstance:arr[1]];
    NSLog(@"根据实例查找类中的名字%@",string);
    
    [self getPropertyNameAndEncode];
    
}

#pragma mark instance可以动态修改
- (NSString *)nameWithInstance:(id)instance
{
    unsigned int numIvars = 0;
    NSString *key = nil;
    Ivar *ivars = class_copyIvarList([self class], &numIvars);//这里要引入#import <objc/runtime.h>，不然会有错误
    int i;
    for (i = 0; i < numIvars; i ++)
    {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        if ((object_getIvar(self, thisIvar) == instance)) {//此处会有crash
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
        
    }
    free(ivars);
    return key;
}

#pragma mark 返回属性名字
- (void)getPropertyNameAndEncode
{
    id myobjectClass = objc_getClass("MyObject");
    unsigned int outCount;
    //属性列表，实际上是指向属性列表结构体的一个指针,取outCount的地址是为了直接给outCount赋值，相当于新增了一个返回值。
    objc_property_t *properties = class_copyPropertyList(myobjectClass, &outCount);
    
    //这里只会查询属性
    objc_property_t *classPropety = class_getProperty(myobjectClass, "floatProperty");
    
    //这里查询ivar内容
    Ivar *ivars = class_copyIvarList(myobjectClass, &outCount);
    int i;
    for (i = 0; i < outCount; i ++)
    {
        Ivar thisIvar = ivars[i];
        
        //        const char *string = ivar_getName(thisIvar);
        const char *string = ivar_getTypeEncoding(thisIvar);
        NSString *stringProperty = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
        NSLog(@"%@",stringProperty);
    }
    const char *string = property_getAttributes(classPropety);
    NSString *stringProperty = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
    NSLog(@"%@",stringProperty);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
