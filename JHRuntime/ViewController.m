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
#import "Student.h"

@interface ViewController ()
{
    float floatIvar;
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
    
    NSArray* arr = @[obj, obj2, @"floatIvar"];
    
    NSString *string = [self nameWithInstance:arr[1]];
    NSLog(@"根据实例查找类中的名字%@",string);
    
    [self getPropertyNameAndEncode];
    
    //测试ivar_getOffSet
    Student *student = [[Student alloc] init];
    Ivar age_ivar = class_getInstanceVariable(object_getClass(student), "age");
    int *age_pointer = (int *)((__bridge void *)(student) + ivar_getOffset(age_ivar));
    NSLog(@"age ivar offset = %td", ivar_getOffset(age_ivar));
    *age_pointer = 10;
    NSLog(@"%@", student);
    
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
        if (![stringType hasPrefix:@"@"]) {//这里如果不是对象类型，例如float或者int，会输出@“f”挥着@“i”
            continue;
        }
        if ((object_getIvar(self, thisIvar) == instance)) {//此处可能会有crash
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
    
    //这里查询ivar内容
    Ivar *ivars = class_copyIvarList(myobjectClass, &outCount);
    int i;
    for (i = 0; i < outCount; i ++)
    {
        Ivar thisIvar = ivars[i];
        
        const char *string = ivar_getName(thisIvar);
//        const char *string = ivar_getTypeEncoding(thisIvar);
        NSString *stringProperty = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
        NSLog(@"获取到的ivar名字%@",stringProperty);
    }
    
    //这里只会查询属性
    objc_property_t classProperty = class_getProperty(myobjectClass, "floatProperty");
    
    
    unsigned int proCount;
    int j;
    objc_property_t *properties = class_copyPropertyList(myobjectClass, &proCount);
    for (j = 0; j < proCount; j ++)
    {
        objc_property_t property = properties[j];
        const char *proName = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:proName encoding:NSUTF8StringEncoding];
        const char *string = property_getAttributes(property);
        NSString *stringProperty = [NSString stringWithCString:string encoding:NSUTF8StringEncoding];
        NSLog(@"获取到的property名字%@，参数信息%@", propertyName,stringProperty);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
