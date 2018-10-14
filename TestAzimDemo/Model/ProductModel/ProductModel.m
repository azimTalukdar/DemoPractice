//
//  ProductModel.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ProductModel.h"



@implementation ProductModel


-(id)initWithData:(NSDictionary *)dict
{
//    NSLog(@"ProductModel initWithData %@",dict);
    self = [super init];
    if (self) {
        _meta = [[MetaModel alloc] initWithData:[dict objectForKey:@"meta"]];
        ObjectModel *model_ = [[ObjectModel alloc] init];
        _objects = [model_ createArray:[dict objectForKey:@"objects"]];
    }
    return self;
}

@end
