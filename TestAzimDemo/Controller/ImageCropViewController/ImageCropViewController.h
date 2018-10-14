//
//  ImageCropViewController.h
//  TestAzimDemo
//
//  Created by AZIM-PC on 11/10/18.
//  Copyright © 2018 Azim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TOCropViewController.h>

@interface ImageCropViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
- (IBAction)CropPressed:(id)sender;
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle;
@end
