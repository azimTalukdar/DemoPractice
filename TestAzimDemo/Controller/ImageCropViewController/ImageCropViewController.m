//
//  ImageCropViewController.m
//  TestAzimDemo
//
//  Created by AZIM-PC on 11/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import "ImageCropViewController.h"
#import <BFRImageViewController.h>
#import <BFRImageTransitionAnimator.h>


@interface ImageCropViewController ()<TOCropViewControllerDelegate>

@property (nonatomic,strong) BFRImageTransitionAnimator *imageViewAnimator;

@end

@implementation ImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageViewAnimator = [BFRImageTransitionAnimator new];
    [self setUpImageView];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"< BACK" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];//\U000025C0\U0000FE0E
    [self.navigationItem setLeftBarButtonItem:back];
    
}

- (IBAction)back:(id)sender {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self.navigationController popViewControllerAnimated:NO]; }
                    completion:NULL];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [UIView beginAnimations:@"animation" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration: 0.7];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//    [UIView commitAnimations];
}

-(void)setUpImageView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowImageInFull)];
    singleTap.numberOfTapsRequired = 1;
    [self.imageViewProduct setUserInteractionEnabled:YES];
    [self.imageViewProduct addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image View
-(void)ShowImageInFull
{
    self.imageViewAnimator.animatedImageContainer = self.imageViewProduct;
    self.imageViewAnimator.animatedImage = self.imageViewProduct.image;
    self.imageViewAnimator.imageOriginFrame = self.imageViewProduct.frame;
    self.imageViewAnimator.desiredContentMode = self.imageViewProduct.contentMode; //Optional
    
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[self.imageViewProduct.image]];
    imageVC.transitioningDelegate = self.imageViewAnimator;
    
    [self presentViewController:imageVC animated:YES completion:nil];
}

#pragma mark - Image Crop
- (void)presentCropViewController
{
    UIImage *image = self.imageViewProduct.image; //Load an image
    
    TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithImage:image];
    cropViewController.delegate = self;
    [self presentViewController:cropViewController animated:YES completion:nil];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    // 'image' is the newly cropped version of the original image
    [self dismissViewControllerAnimated:YES completion:^{
        self.imageViewProduct.image = image;
    }];
    
}

- (IBAction)CropPressed:(id)sender {
    [self presentCropViewController];
}
@end
