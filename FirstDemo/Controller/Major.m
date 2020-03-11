//
//  Major.m
//  FirstDemo
//
//  Created by edward on 2020/3/7.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "Major.h"
@interface Major(){
    @private
    NSString *myname;
}
@end

@implementation Major

// ⏬Archive 实现两个方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.sax forKey:@"sax"];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self.sax = [coder decodeObjectForKey:@"sax"];
    return self;
}
@end
