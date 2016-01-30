//
//  main.m
//  RuntimeDemo
//
//  Created by liuxj on 16/1/29.
//  Copyright © 2016年 LXJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "LXJObject+Category.h"
#import "LXJObject.h"

void guessAnswer(id self, SEL _cmd);

@interface Control : NSObject
@property (nonatomic, strong) LXJObject *lxjObject;
- (void)varControl;
- (void)methodsExchange;
- (void)addMethod;
@end

@implementation Control

//
- (void)varControl
{
    NSLog(@"====================== %s ==========================", __func__);
    self.lxjObject = [[LXJObject alloc] init];
    NSLog(@"old name = %@", self.lxjObject.publicProperty);
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.lxjObject class], &count);
    for (int i=0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        NSLog(@"varName = %@", name);
        if ([name isEqualToString:@"_publicProperty"]) {
            object_setIvar(self.lxjObject, var, @"PRIVATE PROPERTY");
            break;
        }
    }
    NSLog(@"new name = %@\n", self.lxjObject.publicProperty);
    NSLog(@"====================== %s ==========================", __func__);
}

- (void)methodsExchange
{
    NSLog(@"====================== %s ==========================", __func__);
    self.lxjObject = [[LXJObject alloc] init];
    NSLog(@"firstSay = %@", [self.lxjObject firstMethod]);
    NSLog(@"secondSay = %@", [self.lxjObject secondMethod]);
    
    Method m1 = class_getInstanceMethod([self.lxjObject class], @selector(firstMethod));
    Method m2 = class_getInstanceMethod([self.lxjObject class], @selector(secondMethod));
    method_exchangeImplementations(m1, m2);

    NSLog(@"firstSay = %@", [self.lxjObject firstMethod]);
    NSLog(@"secondSay = %@", [self.lxjObject secondMethod]);
    NSLog(@"====================== %s ==========================", __func__);
}

- (void)addMethod
{
    NSLog(@"====================== %s ==========================", __func__);
    self.lxjObject = [[LXJObject alloc] init];
    class_addMethod([self.lxjObject class], @selector(guess), (IMP)guessAnswer, "v@:");

    if ([self.lxjObject respondsToSelector:@selector(guess)]) {
        [self.lxjObject performSelector:@selector(guess)];
    } else {
        NSLog(@"Sorry, I don't know.");
    }

    NSLog(@"====================== %s ==========================", __func__);
}

- (void)addPropertyCategory
{
    NSLog(@"====================== %s ==========================", __func__);
    self.lxjObject = [[LXJObject alloc] init];
    self.lxjObject.otherProperty = @"other property";
    NSLog(@"chinese name = %@", self.lxjObject.otherProperty);
    NSLog(@"====================== %s ==========================", __func__);
}

@end

void guessAnswer(id self, SEL _cmd)
{
    NSLog(@"adding methods");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Control *ctrl = [[Control alloc] init];

        // 动态控制变量
        [ctrl varControl];

        // 动态交换方法
        [ctrl methodsExchange];
        
        // 动态添加方法
        [ctrl addMethod];
        
        // Category 添加属性
        [ctrl addPropertyCategory];
    }
    return 0;
}
