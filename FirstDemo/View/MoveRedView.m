//
//  MoveRedView.m
//  FirstDemo
//
//  Created by edward on 2019/11/19.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "MoveRedView.h"

@implementation MoveRedView


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint before = [[touches anyObject] previousLocationInView:self];
    CGPoint local = [[touches anyObject] locationInView:self];
    CGFloat movex = local.x - before.x;
    CGFloat movey = local.y - before.y;
    self.transform = CGAffineTransformTranslate(self.transform, movex, movey);
//    CGPoint lo = self.frame.origin;
//    if(lo.x<100 && lo.y<100)
//    {
//        NSLog(@"大于");
//    }
}


@end
