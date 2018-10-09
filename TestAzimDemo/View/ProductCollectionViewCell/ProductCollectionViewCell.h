//
//  ProductCollectionViewCell.h
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

-(void)configureCell;
@end
