//
//  ProductCollectionViewCell.m
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductCollectionViewCell



-(void)configureCell:(ObjectModel *)model ULR:(NSString *)url
{
    [_imgProduct sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _lblTitle.text = [NSString stringWithFormat:@"%@\n(₹ %ld)",model.name,(long)model.cost];
}

@end
