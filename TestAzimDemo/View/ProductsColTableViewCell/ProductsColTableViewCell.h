//
//  ProductsColTableViewCell.h
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsColTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segFilter;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewProducts;

-(void)ConfigureCell:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate IndexPath:(NSIndexPath *)indexPath;
@end
