//
//  ObjectModel.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ObjectModel.h"

@implementation ObjectModel

-(NSMutableArray *)createArray:(NSDictionary *)dict
{
    NSMutableArray *objectsArr = [[NSMutableArray alloc] init];
    if (self) {
        for (NSDictionary *dict1 in [dict objectForKey:@"objects"]) {
            _sku = (NSInteger)[dict1 objectForKey:@"sku"];
            _name = (NSString *)[dict1 objectForKey:@"name"];
            _cost = (NSInteger)[dict1 objectForKey:@"cost"];
            [objectsArr addObject:self];
        }
    }
    return objectsArr;
}

@end
