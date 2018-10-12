//
//  ProductsColTableViewCell.m
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ProductsColTableViewCell.h"

@implementation ProductsColTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)ConfigureCell:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate IndexPath:(NSIndexPath *)indexPath Dictionary:(NSDictionary *)dataDict
{
    _lblTitle.text = [[dataDict objectForKey:@"category"] uppercaseString];
    int isSorted = [[dataDict objectForKey:@"isSorted"] intValue];
    [_segFilter setSelectedSegmentIndex:isSorted];
    
    _collectionViewProducts.delegate = dataSourceDelegate;
    _collectionViewProducts.dataSource = dataSourceDelegate;
    
    _collectionViewProducts.tag = indexPath.row;
//    _collectionViewProducts.dragDelegate = dataSourceDelegate
    
    [_collectionViewProducts reloadData];
    
}

@end
