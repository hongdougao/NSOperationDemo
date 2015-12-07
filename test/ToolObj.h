//
//  ToolObj.h
//  test
//
//  Created by yangyue on 15/12/7.
//  Copyright © 2015年 com.yy.www. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, YYToolRequestState) {
    YYToolRequestStateReady     = 0,
    YYToolRequestStateExecuting = 1,
    YYToolRequestStateFinished  = 2,
};



@interface ToolObj : NSOperation


@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, strong) NSSet *runLoopModes;

@property (nonatomic, assign) YYToolRequestState state;

@end
