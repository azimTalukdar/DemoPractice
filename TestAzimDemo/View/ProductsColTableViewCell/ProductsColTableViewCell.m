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
    
    _collectionViewProducts.dragInteractionEnabled = YES;
    
    _collectionViewProducts.delegate = dataSourceDelegate;
    _collectionViewProducts.dataSource = dataSourceDelegate;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    [_collectionViewProducts addGestureRecognizer:longPressGesture];
    
    _collectionViewProducts.tag = indexPath.row;
//    _collectionViewProducts.dragDelegate = dataSourceDelegate
    
    [_collectionViewProducts reloadData];
    
}

-(void)handleLongGesture:(UILongPressGestureRecognizer *)gesture
{
    
//    if (gesture.state != UIGestureRecognizerStateEnded) {
//        return;
//    }
//    NSLog(@"Long gesture initiated");
    CGPoint point_ = [gesture locationInView:_collectionViewProducts];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [_collectionViewProducts indexPathForItemAtPoint:point_];
            NSLog(@"handleLongGesture in Cell index %ld",(long)indexPath.item);
            if (indexPath != nil) {
                [_collectionViewProducts beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [_collectionViewProducts updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [_collectionViewProducts endInteractiveMovement];
            break;
        }
            
        default:
            [_collectionViewProducts cancelInteractiveMovement];
            break;
    }
}

@end
