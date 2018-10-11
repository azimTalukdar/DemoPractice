//
//  ViewController.h
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableWithCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableCollapsableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantTableCollection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantTableCollapsable;
@end

