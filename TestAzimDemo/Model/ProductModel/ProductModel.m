//
//  ProductModel.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ProductModel.h"



@implementation ProductModel

//-(ProductModel *)createModel:(NSDictionary *)dict
//{
//    ATMeta *meta_ = [[ATMeta alloc] init];
//    meta_.count = (NSInteger)[[dict objectForKey:@"meta"] objectForKey:@"count"];
//    meta_.isSuccess = (BOOL)[[dict objectForKey:@"meta"] objectForKey:@"success"];
//
//    NSMutableArray *objectsArr = [[NSMutableArray alloc] init];
//    for (NSDictionary *dict1 in [dict objectForKey:@"objects"]) {
//        ATObject *object_ = [[ATObject alloc] init];
//        object_.sku = (NSInteger)[dict1 objectForKey:@"sku"];
//        object_.name = (NSString *)[dict1 objectForKey:@"name"];
//        object_.cost = (NSInteger)[dict1 objectForKey:@"cost"];
//        [objectsArr addObject:object_];
//    }
    
//    ProductModel *productModel_ = [[ProductModel alloc] init];
//    _meta = [[MetaModel alloc] initWithData:dict];
//    ObjectModel *model_ = [[ObjectModel alloc] init];
//    _objects = [model_ createArray:[dict objectForKey:@"object"]];
//    return self;
//}

-(id)initWithData:(NSDictionary *)dict
{
    NSLog(@"ProductModel initWithData %@",dict);
    self = [super init];
    if (self) {
        _meta = [[MetaModel alloc] initWithData:[dict objectForKey:@"meta"]];
        NSLog(@"ProductModel %d",_meta.count);
        ObjectModel *model_ = [[ObjectModel alloc] init];
        _objects = [model_ createArray:[dict objectForKey:@"objects"]];
    }
    return self;
}

@end
