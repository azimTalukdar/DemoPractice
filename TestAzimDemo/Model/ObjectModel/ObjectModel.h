//
//  ObjectModel.h
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectModel : NSObject
@property (nonatomic, assign) NSInteger sku;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger cost;
-(NSMutableArray *)createArray:(NSDictionary *)dict;
@end
