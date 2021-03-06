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
#import "ProductModel.h"
#import "ImageCropViewController.h"

static int const kHeaderSectionTag = 6900;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *categoryArr;
    NSArray *productsArr;
    int serviceNo;
    NSArray *serviceArr;
    NSArray *imageProductArr;
}
@property (assign) NSInteger expandedSectionHeaderNumber;
@property (assign) UITableViewHeaderFooterView *expandedSectionHeader;
@property (nonatomic,strong) UISwitch *switchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSpashImage];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.topViewController.title = @"PRODUCTSs";
    
    [self initVariable];
    [self addSwitchBarButton];
    [self setUpTable];
    [self setObserverForOrientation];
//    [self getService];
}

-(void)addSpashImage
{
    UIView *myView = [[UIView alloc]  init];
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    myView.frame = currentWindow.frame;
    NSLog(@"Frame is %f-%f",currentWindow.frame.size.width,currentWindow.frame.size.height);
    _imgSplash = [[UIImageView alloc] initWithFrame:currentWindow.frame];
    _imgSplash.image = [UIImage imageNamed:@"fyndLogo"];
    _imgSplash.backgroundColor = [UIColor whiteColor];
    _imgSplash.contentMode = UIViewContentModeScaleAspectFit;
    [currentWindow addSubview:_imgSplash];
}

-(void)initVariable
{
    categoryArr = [[NSMutableArray alloc]  init];
    self.expandedSectionHeaderNumber = -1;
    serviceNo = 0;
    serviceArr = [[NSArray alloc] initWithObjects:@"jackets",@"polos",@"shirts", nil];//@"sweatshirt"
    imageProductArr = [[NSArray alloc] initWithObjects:JACKET_URL,POLO_URL,SHIRT_URL, nil];

    [self getService:serviceArr[serviceNo]];
    
}

-(void)getService:(NSString *)service
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *finalUrl = [NSString stringWithFormat:@"%@/%@",BASE_URL,service];
    NSURL *URL = [NSURL URLWithString:finalUrl];NSLog(@"url is %@",finalUrl);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ url succeded",service);
            ProductModel *modelProdcut = [[ProductModel alloc]  initWithData:responseObject];
            NSMutableDictionary *dict_ = [[NSMutableDictionary alloc] init];
            [dict_ setObject:service forKey:CATEGORY_KEY];
            [dict_ setObject:modelProdcut.objects forKey:PRODUCTS_KEY];
            [dict_ setObject:[NSNumber numberWithInt:0] forKey:IS_SORTED_KEY];
            [self->categoryArr addObject:dict_];
            
            [self->_tableWithCollectionView reloadData];
            [self->_tableCollapsableView reloadData];
        }
        self->serviceNo++;
        if (self->serviceNo < self->serviceArr.count) {
            [self getService:self->serviceArr[self->serviceNo]];
        }
        else
        {
            [self removeSplashScreen];
        }
        
        
    }];
    [dataTask resume];
}

-(void)removeSplashScreen
{
    [UIView animateWithDuration:0.5 animations:^{
        self->_imgSplash.transform = CGAffineTransformMakeScale(10, 10);
        self->_imgSplash.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
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
//    UIDevice * device = note.object;
    [_tableWithCollectionView reloadData];
    [_tableCollapsableView reloadData];

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
        [self displayCollectionTable:NO];
    }else{
        //Show Collection
        [self displayCollectionTable:YES];
    }
}

-(void)displayCollectionTable:(BOOL)isDisplay
{

    if (isDisplay) {
        _tableWithCollectionView.alpha = 1;
        _tableCollapsableView.alpha = 0;
    }
    else
    {
        _tableWithCollectionView.alpha = 0;
        _tableCollapsableView.alpha = 1;
    }
}

#pragma mark - TableView init, Delegate and Datasource

-(void)setUpTable
{
    _tableWithCollectionView.delegate = self;
    _tableWithCollectionView.dataSource = self;
    
    _tableCollapsableView.delegate = self;
    _tableCollapsableView.dataSource = self;
    
    _tableCollapsableView.alpha = 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableCollapsableView) {
        return categoryArr.count;
    }
    else
    {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableCollapsableView) {
        if (self.expandedSectionHeaderNumber == section) {
            NSArray *objects = [[categoryArr objectAtIndex:section] objectForKey:PRODUCTS_KEY];
            return objects.count;
        } else {
            return 0;
        }
        
    }
    else
    {
        return categoryArr.count;
    }
    
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
    static NSString *identifierRowNormal = @"defaultCell";//
    if (tableView == _tableCollapsableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierRowNormal];
        ObjectModel *model_ = [[[categoryArr objectAtIndex:indexPath.section] objectForKey:PRODUCTS_KEY] objectAtIndex:indexPath.row];
        cell.textLabel.text = model_.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",model_.cost];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        ProductsColTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierRow];
        cell.segFilter.tag = indexPath.row;
        [cell.segFilter addTarget:self action:@selector(filerProduct:) forControlEvents:UIControlEventValueChanged];
        [cell ConfigureCell:self IndexPath:indexPath Dictionary:[categoryArr objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"You selected Table Cell");
    if (tableView == _tableCollapsableView) {
        [self openCropVC];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableCollapsableView) {
        return [[[categoryArr objectAtIndex:section] objectForKey:CATEGORY_KEY] uppercaseString];
    }
    else
    {
        return @"";
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // recast your view as a UITableViewHeaderFooterView
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = FYND_COLOR_PINK1;//[UIColor lightGrayColor];
    header.textLabel.textColor = [UIColor whiteColor];
    UIImageView *viewWithTag = [self.view viewWithTag:kHeaderSectionTag + section];
    if (viewWithTag) {
        [viewWithTag removeFromSuperview];
    }
    // add the arrow image
    CGSize headerFrame = self.view.frame.size;
    UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 32, 13, 18, 18)];
    theImageView.image = [UIImage imageNamed:@"Chevron-Dn-Wht"];
    theImageView.tag = kHeaderSectionTag + section;
    [header addSubview:theImageView];

    // make headers touchable
    header.tag = section;
    UITapGestureRecognizer *headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderWasTouched:)];
    [header addGestureRecognizer:headerTapGesture];
}

#pragma mark - Expand / Collapse Methods

- (void)sectionHeaderWasTouched:(UITapGestureRecognizer *)sender {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)sender.view;
    NSInteger section = headerView.tag;
    UIImageView *eImageView = (UIImageView *)[headerView viewWithTag:kHeaderSectionTag + section];
    self.expandedSectionHeader = headerView;
    
    if (self.expandedSectionHeaderNumber == -1) {
        self.expandedSectionHeaderNumber = section;
        [self tableViewExpandSection:section withImage: eImageView];
    } else {
        if (self.expandedSectionHeaderNumber == section) {
            [self tableViewCollapeSection:section withImage: eImageView];
            self.expandedSectionHeader = nil;
        } else {
            UIImageView *cImageView  = (UIImageView *)[self.view viewWithTag:kHeaderSectionTag + self.expandedSectionHeaderNumber];
            [self tableViewCollapeSection:self.expandedSectionHeaderNumber withImage: cImageView];
            [self tableViewExpandSection:section withImage: eImageView];
        }
    }
}

- (void)tableViewCollapeSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [[categoryArr objectAtIndex:section] objectForKey:PRODUCTS_KEY];
    
    self.expandedSectionHeaderNumber = -1;
    if (sectionData.count == 0) {
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((0.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        [self.tableCollapsableView beginUpdates];
        [self.tableCollapsableView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableCollapsableView endUpdates];
    }
}

- (void)tableViewExpandSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [[categoryArr objectAtIndex:section] objectForKey:PRODUCTS_KEY];
    
    if (sectionData.count == 0) {
        self.expandedSectionHeaderNumber = -1;
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((180.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        self.expandedSectionHeaderNumber = section;
        [self.tableCollapsableView beginUpdates];
        [self.tableCollapsableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableCollapsableView endUpdates];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    if (tableView == _tableCollapsableView) {
        return 44.0;
    }
    else
    {
        return 0;
    }
}

#pragma mark Arranging collectioncell

-(void)filerProduct:(id)sender
{
    UISegmentedControl* segmentedControl = (UISegmentedControl*)sender;
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"sort by name");
            [self sortOrderOfCell:(int)[sender tag] Name:@"name"];
            break;
            
        case 1:
            NSLog(@"sort by price");
            [self sortOrderOfCell:(int)[sender tag] Name:@"cost"];
            break;
            
        default:
            break;
    }
}

-(void)sortOrderOfCell:(int)rowNo Name:(NSString *)type
{
    NSDictionary *dict = [categoryArr objectAtIndex:rowNo];
    NSArray *arr = [dict objectForKey:PRODUCTS_KEY];
    
    NSArray *sortedArray;
    int isSorted;
    if ([type isEqualToString:@"name"]) {
        sortedArray = [arr sortedArrayUsingComparator:^NSComparisonResult(ObjectModel *p1, ObjectModel *p2){
            return [p1.name compare:p2.name];
        }];
        isSorted = 0;
    }
    else
    {
        sortedArray = [arr sortedArrayUsingComparator: ^(ObjectModel *p1, ObjectModel *p2) {
            
            if ( p1.cost < p2.cost ) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if ( p1.cost > p2.cost ) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        isSorted = 1;
    }
    NSMutableDictionary *catDict = [categoryArr objectAtIndex:rowNo];
    [catDict setObject:sortedArray forKey:PRODUCTS_KEY];
    [catDict setObject:[NSNumber numberWithInt:isSorted] forKey:IS_SORTED_KEY];
    [categoryArr replaceObjectAtIndex:rowNo withObject:catDict];
    
//    for (ObjectModel *model in sortedArray) {
//        NSLog(@"%@- %d",model.name,model.cost);
//    }
    
    [self reloadRowSection:rowNo];
}

- (void)reloadRowSection:(int)rowNo
{
    [self.tableWithCollectionView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNo inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableWithCollectionView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableWithCollectionView endUpdates];
}


#pragma mark - Collection delegate and datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dict = [categoryArr objectAtIndex:collectionView.tag];
    return [(NSArray *)[dict objectForKey:PRODUCTS_KEY] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int itemsCols = 3;
    int itemsRows = 2;
    
    
    CGSize size_ = collectionView.frame.size;
    
    return CGSizeMake(size_.width/itemsCols-4, size_.height/itemsRows);
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"from %ld",(long)sourceIndexPath.item);
    NSLog(@"to %ld",(long)destinationIndexPath.item);
    NSLog(@"collection tag %ld",collectionView.tag);
    
    ObjectModel *A = [[[categoryArr objectAtIndex:collectionView.tag] objectForKey:PRODUCTS_KEY] objectAtIndex:sourceIndexPath.item];
//    ObjectModel *B = [[[categoryArr objectAtIndex:collectionView.tag] objectForKey:PRODUCTS_KEY] objectAtIndex:destinationIndexPath.item];
    
    NSMutableArray *sortedArr = [[[categoryArr objectAtIndex:collectionView.tag] objectForKey:PRODUCTS_KEY] mutableCopy];
    if (destinationIndexPath.item > sourceIndexPath.item)
    {
        for (int i = (int)sourceIndexPath.item; i<=destinationIndexPath.item; i++) {
            if (i == destinationIndexPath.item)
                [sortedArr replaceObjectAtIndex:i withObject:A];
            else
                [sortedArr replaceObjectAtIndex:i withObject:[sortedArr objectAtIndex:i+1]];
        }
    }
    else
    {
        for (int i = (int)sourceIndexPath.item; i>=destinationIndexPath.item; i--) {
            if (i == destinationIndexPath.item)
                [sortedArr replaceObjectAtIndex:i withObject:A];
            else
                [sortedArr replaceObjectAtIndex:i withObject:[sortedArr objectAtIndex:i-1]];
        }
    }
    
//    [sortedArr replaceObjectAtIndex:sourceIndexPath.item withObject:B];
//    [sortedArr replaceObjectAtIndex:destinationIndexPath.item withObject:A];
    
    NSMutableDictionary *catDict = [categoryArr objectAtIndex:collectionView.tag];
    [catDict setObject:sortedArr forKey:PRODUCTS_KEY];
    [categoryArr replaceObjectAtIndex:collectionView.tag withObject:catDict];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCol = @"ProductCollectionViewCell";
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCol forIndexPath:indexPath];
    NSDictionary *dict = [categoryArr objectAtIndex:collectionView.tag];
    ObjectModel *model_ = [[dict objectForKey:PRODUCTS_KEY] objectAtIndex:indexPath.item];
    [cell configureCell:model_ ULR:[imageProductArr objectAtIndex:collectionView.tag]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"You selected Collection Cell");
    [self openCropVC];
}

#pragma mark - open Crop ViewController
-(void)openCropVC
{
    ImageCropViewController *cropVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageCropViewController"];
//    [self.navigationController pushViewController:cropVC animated:YES];
    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController pushViewController: cropVC animated:NO];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}


@end
