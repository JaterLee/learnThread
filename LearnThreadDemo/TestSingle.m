//
//  TestSingle.m
//  LearnThreadDemo
//
//  Created by Jater on 2018/7/14.
//  Copyright © 2018年 李军灼. All rights reserved.
//

#import "TestSingle.h"

@implementation TestSingle

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static TestSingle *ins = nil;
    dispatch_once(&onceToken, ^{
        NSLog(@"init the TestSingle");
        ins = [TestSingle new];
    });
    return ins;
}

@end
