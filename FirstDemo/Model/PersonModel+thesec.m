//
//  PersonModel+thesec.m
//  FirstDemo
//
//  Created by edward on 2020/3/4.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "PersonModel+thesec.h"


#import <objc/message.h>

@implementation PersonModel (thesec)
- (id)father{
    id value = objc_getAssociatedObject(self, "father");
    return value;
}
- (void)setFather:(NSString *)father{
    objc_setAssociatedObject(self, "father", father, OBJC_ASSOCIATION_RETAIN);
    
}
@end
