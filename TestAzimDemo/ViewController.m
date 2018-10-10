//
//  ViewController.m
//  TestAzimDemo
//
//  Created by AZIM-PC on 09/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ViewController.h"
#import "ProductsColTableViewCell.h"
#import "ProductCollectionViewCell.h"
#import <AFNetworking.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UISwitch *switchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.topViewController.title = @"Demo";
    [self addSwitchBarButton];
    [self setUpTable];
    [self setObserverForOrientation];
    [self getService];
}

-(void)getService
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ AZIM %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation Changed
-(void)setObserverForOrientation
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            /* start special animation */
            NSLog(@"UIDeviceOrientationPortrait");
            [_tableWithCollectionView reloadData];
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            /* start special animation */
            NSLog(@"UIDeviceOrientationLandscapeLeft");
            [_tableWithCollectionView reloadData];
            break;
            
        case UIDeviceOrientationLandscapeRight:
            /* start special animation */
            NSLog(@"UIDeviceOrientationLandscapeRight");
            [_tableWithCollectionView reloadData];
            break;
            
        default:
            break;
    };
}

#pragma mark - Switch navigation Bar
-(void)addSwitchBarButton
{
    _switchView = [[UISwitch alloc] init];
    [_switchView addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem* switchItem = [[UIBarButtonItem alloc] initWithCustomView:_switchView];
    self.navigationItem.rightBarButtonItem = switchItem;
}

-(void)switchPressed:(id)sender
{
    if (_switchView.isOn) {
        //Show Table
    }else{
        //Show Collection
    }
}

#pragma mark - TableView init, Delegate and Datasource

-(void)setUpTable
{
    _tableWithCollectionView.delegate = self;
    _tableWithCollectionView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierRow = @"ProductsColTableViewCell";
    ProductsColTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierRow];
    cell.segFilter.tag = indexPath.row;
    [cell.segFilter addTarget:self action:@selector(filerProduct:) forControlEvents:UIControlEventValueChanged];
    [cell ConfigureCell:self];
    return cell;
}

-(void)filerProduct:(id)sender
{
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"Name selected");
            break;
            
        case 1:
            NSLog(@"Price selected");
            break;
            
        default:
            break;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"You selected Table Cell");
}

#pragma mark - Collection init, delegate and datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int itemsCols = 3;
    int itemsRows = 2;
    
    
    CGSize size_ = collectionView.frame.size;
    
    return CGSizeMake(size_.width/itemsCols, size_.height/itemsRows);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCol = @"ProductCollectionViewCell";
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCol forIndexPath:indexPath];
    [cell configureCell];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"You selected Collection Cell");
}



@end
