//
//  UIViewController+YYK.m
//  
//


#import "UIViewController+YYK.h"

#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIColor+YYK.h"
#import "UIAlertController+YYK.h"

#define KAPPNAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define KAPPENDAPPNAME(formatString) [NSString stringWithFormat:formatString,KAPPNAME]

@implementation UIViewController (YYK)

- (void)yk_showPhotoLibraryWithAllowEdit:(BOOL)allowEdit
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor yk_colorWithHexString:@"#1A1817"];
    [imagePicker.navigationBar setTitleTextAttributes:attrs];
    imagePicker.allowsEditing = allowEdit;
    imagePicker.delegate = self;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        UIAlertController *confirm = [UIAlertController yk_alertWithOKButtonWithTitle:@"提示" message:KAPPENDAPPNAME(@"请前往“设置-隐私-照片”选项中，允许%@访问您的手机相册")];
        [self presentViewController:confirm animated:YES completion:nil];
        return;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)yk_showCameraWithAllowEdit:(BOOL)allowEdit
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor yk_colorWithHexString:@"#1A1817"];
    [imagePicker.navigationBar setTitleTextAttributes:attrs];
    imagePicker.allowsEditing = allowEdit;
    imagePicker.delegate = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
    {
        UIAlertController *confirm = [UIAlertController yk_alertWithOKButtonWithTitle:@"提示" message:KAPPENDAPPNAME(@"请前往“设置-隐私”选项中，允许%@访问您的摄像头")];
        [self presentViewController:confirm animated:YES completion:nil];
        return;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)yk_showImagePickerWithSourceView:(UIView *)sourceView
{
    [self yk_showImagePickerWithSourceView:sourceView allowEdit:YES];
}

- (void)yk_showImagePickerWithSourceView:(UIView *)sourceView allowEdit:(BOOL)allowEdit
{
    @weakify(self);
    UIAlertController *alert = [UIAlertController yk_ipad_actionSheetWithTitle:nil message:nil btnTitles:@[@"相册",@"相机"] sourceView:self.view clickBtnAtIndex:^(NSInteger index) {
        @strongify(self);
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = allowEdit;
        imagePicker.delegate = self;
        if (index == 0) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                UIAlertController *confirm = [UIAlertController yk_alertWithOKButtonWithTitle:@"提示" message:KAPPENDAPPNAME(@"请前往“设置-隐私-照片”选项中，允许%@访问您的手机相册")];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else if (index == 1){
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
            {
                UIAlertController *confirm = [UIAlertController yk_alertWithOKButtonWithTitle:@"提示" message:KAPPENDAPPNAME(@"请前往“设置-隐私”选项中，允许%@访问您的摄像头")];
                [self presentViewController:confirm animated:YES completion:nil];
                return;
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        alert.popoverPresentationController.sourceView = sourceView;
        alert.popoverPresentationController.sourceRect = sourceView.bounds;
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self yk_getPickerImage:[self fixOrientation:image]];
    } else {
         [self yk_getPickerImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)fixOrientation:(UIImage*)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//- (void)yk_getPickerImage:(UIImage *)image
//{
//
//}

@end
