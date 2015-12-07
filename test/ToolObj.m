//
//  ToolObj.m
//  test
//
//  Created by yangyue on 15/12/7.
//  Copyright © 2015年 com.yy.www. All rights reserved.
//

#import "ToolObj.h"

@implementation ToolObj
@synthesize state = _state;


+ (void)toolRequestThreadEntryPoint:(id)__unused object{
    @autoreleasepool {
        [[NSThread currentThread]setName:@"ToolObj"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)toolRequestThread{
    static NSThread *_toolRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _toolRequestThread = [[NSThread alloc]initWithTarget:self selector:@selector(toolRequestThreadEntryPoint:) object:nil];
        [_toolRequestThread start];
    });
    return _toolRequestThread;
}

- (void)start{
    [self. lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] toolRequestThread ]withObject:nil
                waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }else if([self isReady]){
 
        
    }
    [self.lock lock];
}
- (void)finish{
    NSLog(@"finish");
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    self.state = YYToolRequestStateFinished;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];

}
- (void)cancel{
    if (![self isExecuting]) {
        return;
    }
    
    [super cancel]; [self finish];
}
- (void)dealloc{

}
- (YYToolRequestState)state{
    @synchronized(self) {
        return _state;
    }
}
- (void)setState:(YYToolRequestState)newState{
    @synchronized(self) {
        [self willChangeValueForKey:@"state"];
        _state = newState;
        [self didChangeValueForKey:@"state"];
    }
}
-(BOOL)isConcurrent{
    return YES;
}
- (BOOL)isExecuting{
    return self.state = YYToolRequestStateExecuting;
}
- (BOOL)isFinished{
    return self.state = YYToolRequestStateFinished;
}
- (void)cancelConnection {
    
}
@end
