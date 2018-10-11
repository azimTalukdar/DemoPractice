//
//  ImageCropViewController.m
//  TestAzimDemo
//
//  Created by GENEXT-PC on 11/10/18.
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
