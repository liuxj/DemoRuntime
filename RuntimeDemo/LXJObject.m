//
//  XiaoMing.m
//  RuntimeDemo
//
//  Created by liuxj on 16/1/29.
//  Copyright © 2016年 LXJ. All rights reserved.
//

#import "LXJObject.h"

@interface LXJObject()
{
    int privateVar;
}

@property (nonatomic, strong) NSString *privateProperty;

@end

@implementation LXJObject

- (instancetype)init
{
    if (self = [super init]) {
        _publicProperty = @"public property";
    }
    return self;
}


//
- (NSString *)firstMethod
{
    return @"first method";
}
- (NSString *)secondMethod
{
    return @"second method";
}

@end
