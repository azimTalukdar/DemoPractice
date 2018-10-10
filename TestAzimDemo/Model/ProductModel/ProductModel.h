//
//  ProductModel.h
//  TestAzimDemo
//
//  Created by GENEXT-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectModel.h"
#import "MetaModel.h"

//@interface ATMeta : NSObject
//@property (nonatomic, assign) NSInteger count;
//@property (nonatomic, assign) BOOL isSuccess;
//@end
//
//@interface ATObject : NSObject
//@property (nonatomic, assign) NSInteger sku;
//@property (nonatomic, copy)   NSString *name;
//@property (nonatomic, assign) NSInteger cost;
//@end

@interface ProductModel : NSObject
@property (nonatomic, strong) MetaModel *meta;
@property (nonatomic, copy)   NSArray<ObjectModel *> *objects;

-(id) initWithData:(NSDictionary *)dict;
@end





