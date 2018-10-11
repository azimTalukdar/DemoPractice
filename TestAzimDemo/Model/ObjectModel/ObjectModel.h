//
//  ObjectModel.h
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectModel : NSObject
@property (nonatomic, assign) int sku;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) int cost;
-(NSMutableArray *)createArray:(NSDictionary *)dict;

- (NSComparisonResult)compareName:(ObjectModel *)otherObject;
@end
