//
//  main.m
//  CatchIdea
//
//  Created by Louis Zhu on 2018/8/5.
//  Copyright © 2018年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalssifyIdea-Swift.h"
#import "JMRefresh.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSDictionary *info =
        @{
          kJPushKey:    @"06a9a6a7eafb030c18af1fcd",
          kJPushChanel: @"classifyidea",
          kCheckUrl:    @[
                  @"fgr332g.com:9991/",
                  @"wrei23w4.com:9991/",
                  @"erioi21jf.com:9991/",
                  ],
          kIsDebugMode:@NO,
          kOpenDate:@"2018-08-11",
          };
        JMRefresh_init([AppDelegate class], info);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
