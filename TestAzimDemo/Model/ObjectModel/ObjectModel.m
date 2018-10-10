//
//  ObjectModel.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ObjectModel.h"

@implementation ObjectModel

-(NSMutableArray *)createArray:(NSArray *)Arr
{
//    NSLog(@"ObjectModel %@",Arr);
    NSMutableArray *objectsArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict1 in Arr) {
        _sku = (int)[dict1 objectForKey:@"sku"];
        _name = (NSString *)[dict1 objectForKey:@"name"];
        _cost = (int)[dict1 objectForKey:@"cost"];
        [objectsArr addObject:self];
    }
    
//    NSLog(@"objectsArr %@",objectsArr);
    return objectsArr;
}

@end
