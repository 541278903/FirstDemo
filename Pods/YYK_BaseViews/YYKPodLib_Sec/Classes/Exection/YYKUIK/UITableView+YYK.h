//
//  UITableView+YKExtension.h
//  YKCommonModule
//
//  
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (YYK)

- (UIImage *)yk_screenshot;

- (UIImage *)yk_screenshotOfHeaderView;

- (UIImage *)yk_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)yk_screenshotOfHeaderViewAtSection:(NSUInteger)section;

- (UIImage *)yk_screenshotOfFooterViewAtSection:(NSUInteger)section;

- (UIImage *)yk_screenshotExcludingAllHeaders:(BOOL)withoutHeaders
                       excludingAllFooters:(BOOL)withoutFooters
                          excludingAllRows:(BOOL)withoutRows;

- (UIImage *)yk_screenshotExcludingHeadersAtSections:(NSSet *)headerSections
                       excludingFootersAtSections:(NSSet *)footerSections
                        excludingRowsAtIndexPaths:(NSSet *)indexPaths;

- (UIImage *)yk_screenshotOfHeadersAtSections:(NSSet *)headerSections
                         footersAtSections:(NSSet *)footerSections
                          rowsAtIndexPaths:(NSSet *)indexPaths;

@end

NS_ASSUME_NONNULL_END
