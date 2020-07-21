//
//  UIViewController+YYK.h
//  
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YYK)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)yk_showPhotoLibraryWithAllowEdit:(BOOL)allowEdit;

- (void)yk_showCameraWithAllowEdit:(BOOL)allowEdit;

- (void)yk_showImagePickerWithSourceView:(UIView *)sourceView;

- (void)yk_showImagePickerWithSourceView:(UIView *)sourceView allowEdit:(BOOL)allowEdit;

- (void)yk_getPickerImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
