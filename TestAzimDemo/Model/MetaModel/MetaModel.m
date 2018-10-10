//
//  MetaModel.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "MetaModel.h"

@implementation MetaModel

-(id) initWithData:(NSDictionary *)dict
{
//    NSLog(@"MetaModel initWithData %@",dict);
    self = [super init];
    if (self) {
        _count = (int)[dict objectForKey:@"count"];
        _isSuccess = (BOOL)[dict objectForKey:@"success"];
    }
    return self;
}

@end
