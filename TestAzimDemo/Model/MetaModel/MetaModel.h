//
//  MetaModel.h
//  TestAzimDemo
//
//  Created by AZIM-PC on 10/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaModel : NSObject
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL isSuccess;
-(id) initWithData:(NSDictionary *)dict;
@end
