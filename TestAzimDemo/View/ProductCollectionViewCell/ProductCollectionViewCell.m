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



-(void)configureCell:(ObjectModel *)model
{
    [_imgProduct sd_setImageWithURL:[NSURL URLWithString:@"https://d3u4dhauhww2a1.cloudfront.net/product-media/20X/256/256/20-40532640pjpg.jpg"]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _lblTitle.text = [NSString stringWithFormat:@"%@ (%ld)",model.name,(long)model.cost];
}

@end
