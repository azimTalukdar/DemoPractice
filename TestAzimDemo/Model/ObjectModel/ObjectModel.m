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
        ObjectModel *model = [[ObjectModel alloc] init];
        model.sku = (int)[dict1 objectForKey:@"sku"];
        model.name = (NSString *)[dict1 objectForKey:@"name"];
        model.cost = (int)[dict1 objectForKey:@"cost"];
        [objectsArr addObject:model];
    }
    return objectsArr;
}

@end
