//
//  UITableView+YKExtension.m
//  YKCommonModule
//
//  
//

#import "UITableView+YYK.h"
#import "UIView+YYK.h"
#import "UIImage+YYK.h"


@implementation UITableView (YYK)

- (UIImage *)yk_screenshot
{
    return [self yk_screenshotExcludingHeadersAtSections:NO
                           excludingFootersAtSections:NO
                            excludingRowsAtIndexPaths:NO];
}

- (UIImage *)yk_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *cellScreenshot = nil;
    
    // Current tableview offset
    CGPoint currTableViewOffset = self.contentOffset;
    
    // First, scroll the tableview so the cell would be rendered on the view and able to screenshot'it
    [self scrollToRowAtIndexPath:indexPath
                atScrollPosition:UITableViewScrollPositionTop
                        animated:NO];
    
    // Take the screenshot
    cellScreenshot = [[self cellForRowAtIndexPath:indexPath] yk_screenshot];
    
    // scroll back to the original offset
    [self setContentOffset:currTableViewOffset animated:NO];
    
    return cellScreenshot;
}

- (UIImage *)yk_screenshotOfHeaderView
{
    CGPoint originalOffset = [self contentOffset];
    CGRect headerRect = [self tableHeaderView].frame;
    
    [self scrollRectToVisible:headerRect animated:NO];
    UIImage *headerScreenshot = [self yk_screenshotForCroppingRect:headerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return headerScreenshot;
}

- (UIImage *)yk_screenshotOfFooterView
{
    CGPoint originalOffset = [self contentOffset];
    CGRect footerRect = [self tableFooterView].frame;
    
    [self scrollRectToVisible:footerRect animated:NO];
    UIImage *footerScreenshot = [self yk_screenshotForCroppingRect:footerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return footerScreenshot;
}

- (UIImage *)yk_screenshotOfHeaderViewAtSection:(NSUInteger)section
{
    CGPoint originalOffset = [self contentOffset];
    CGRect headerRect = [self rectForHeaderInSection:section];
    
    [self scrollRectToVisible:headerRect animated:NO];
    UIImage *headerScreenshot = [self yk_screenshotForCroppingRect:headerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return headerScreenshot;
}

- (UIImage *)yk_screenshotOfFooterViewAtSection:(NSUInteger)section
{
    CGPoint originalOffset = [self contentOffset];
    CGRect footerRect = [self rectForFooterInSection:section];
    
    [self scrollRectToVisible:footerRect animated:NO];
    UIImage *footerScreenshot = [self yk_screenshotForCroppingRect:footerRect];
    [self setContentOffset:originalOffset animated:NO];
    
    return footerScreenshot;
}

- (UIImage *)yk_screenshotExcludingAllHeaders:(BOOL)withoutHeaders
                       excludingAllFooters:(BOOL)withoutFooters
                          excludingAllRows:(BOOL)withoutRows
{
    NSArray *excludedHeadersOrFootersSections = nil;
    if (withoutHeaders || withoutFooters) excludedHeadersOrFootersSections = [self yk_allSectionsIndexes];
    
    NSArray *excludedRows = nil;
    if (withoutRows) excludedRows = [self yk_allRowsIndexPaths];
    
    return [self yk_screenshotExcludingHeadersAtSections:(withoutHeaders)?[NSSet setWithArray:excludedHeadersOrFootersSections]:nil
                           excludingFootersAtSections:(withoutFooters)?[NSSet setWithArray:excludedHeadersOrFootersSections]:nil
                            excludingRowsAtIndexPaths:(withoutRows)?[NSSet setWithArray:excludedRows]:nil];
}

- (UIImage *)yk_screenshotExcludingHeadersAtSections:(NSSet *)excludedHeaderSections
                       excludingFootersAtSections:(NSSet *)excludedFooterSections
                        excludingRowsAtIndexPaths:(NSSet *)excludedIndexPaths
{
    NSMutableArray *screenshots = [NSMutableArray array];
    // Header Screenshot
    UIImage *headerScreenshot = [self yk_screenshotOfHeaderView];
    if (headerScreenshot) [screenshots addObject:headerScreenshot];
    for (int section=0; section<self.numberOfSections; section++) {
        // Header Screenshot
        UIImage *headerScreenshot = [self yk_screenshotOfHeaderViewAtSection:section excludedHeaderSections:excludedHeaderSections];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        // Screenshot of every cell of this section
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self yk_screenshotOfCellAtIndexPath:cellIndexPath excludedIndexPaths:excludedIndexPaths];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        // Footer Screenshot
        UIImage *footerScreenshot = [self yk_screenshotOfFooterViewAtSection:section excludedFooterSections:excludedFooterSections];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }
    UIImage *footerScreenshot = [self yk_screenshotOfFooterView];
    if (footerScreenshot) [screenshots addObject:footerScreenshot];
    return [UIImage yk_verticalImageFromArray:screenshots];
}

- (UIImage *)yk_screenshotOfHeadersAtSections:(NSSet *)includedHeaderSections
                         footersAtSections:(NSSet *)includedFooterSections
                          rowsAtIndexPaths:(NSSet *)includedIndexPaths
{
    NSMutableArray *screenshots = [NSMutableArray array];
    
    for (int section=0; section<self.numberOfSections; section++) {
        // Header Screenshot
        UIImage *headerScreenshot = [self yk_screenshotOfHeaderViewAtSection:section includedHeaderSections:includedHeaderSections];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        // Screenshot of every cell of the current section
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self yk_screenshotOfCellAtIndexPath:cellIndexPath includedIndexPaths:includedIndexPaths];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        // Footer Screenshot
        UIImage *footerScreenshot = [self yk_screenshotOfFooterViewAtSection:section includedFooterSections:includedFooterSections];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }
    return [UIImage yk_verticalImageFromArray:screenshots];
}

#pragma mark - Hard Working for Screenshots

- (UIImage *)yk_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath excludedIndexPaths:(NSSet *)excludedIndexPaths
{
    if ([excludedIndexPaths containsObject:indexPath]) return nil;
    return [self yk_screenshotOfCellAtIndexPath:indexPath];
}

- (UIImage *)yk_screenshotOfHeaderViewAtSection:(NSUInteger)section excludedHeaderSections:(NSSet *)excludedHeaderSections
{
    if ([excludedHeaderSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self yk_screenshotOfHeaderViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self yk_blankScreenshotOfHeaderAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)yk_screenshotOfFooterViewAtSection:(NSUInteger)section excludedFooterSections:(NSSet *)excludedFooterSections
{
    if ([excludedFooterSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self yk_screenshotOfFooterViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self yk_blankScreenshotOfFooterAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)yk_screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath includedIndexPaths:(NSSet *)includedIndexPaths
{
    if (![includedIndexPaths containsObject:indexPath]) return nil;
    return [self yk_screenshotOfCellAtIndexPath:indexPath];
}

- (UIImage *)yk_screenshotOfHeaderViewAtSection:(NSUInteger)section includedHeaderSections:(NSSet *)includedHeaderSections
{
    if (![includedHeaderSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self yk_screenshotOfHeaderViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self yk_blankScreenshotOfHeaderAtSection:section];
    }
    return sectionScreenshot;
}

- (UIImage *)yk_screenshotOfFooterViewAtSection:(NSUInteger)section includedFooterSections:(NSSet *)includedFooterSections
{
    if (![includedFooterSections containsObject:@(section)]) return nil;
    
    UIImage *sectionScreenshot = nil;
    sectionScreenshot = [self yk_screenshotOfFooterViewAtSection:section];
    if (! sectionScreenshot) {
        sectionScreenshot = [self yk_blankScreenshotOfFooterAtSection:section];
    }
    return sectionScreenshot;
}

#pragma mark - Blank Screenshots

- (UIImage *)yk_blankScreenshotOfHeaderAtSection:(NSUInteger)section
{
    CGSize headerRectSize = CGSizeMake(self.bounds.size.width, [self rectForHeaderInSection:section].size.height);
    return [UIImage yk_imageWithColor:[UIColor clearColor] size:headerRectSize];
}

- (UIImage *)yk_blankScreenshotOfFooterAtSection:(NSUInteger)section
{
    CGSize footerRectSize = CGSizeMake(self.bounds.size.width, [self rectForFooterInSection:section].size.height);
    return [UIImage yk_imageWithColor:[UIColor clearColor] size:footerRectSize];
}

#pragma mark - All Headers / Footers sections

- (NSArray *)yk_allSectionsIndexes
{
    long numOfSections = [self numberOfSections];
    NSMutableArray *allSectionsIndexes = [NSMutableArray array];
    for (int section=0; section < numOfSections; section++) {
        [allSectionsIndexes addObject:@(section)];
    }
    return allSectionsIndexes;
}

#pragma mark - All Rows Index Paths

- (NSArray *)yk_allRowsIndexPaths
{
    NSMutableArray *allRowsIndexPaths = [NSMutableArray array];
    for (NSNumber *sectionIdx in [self yk_allSectionsIndexes]) {
        for (int rowNum=0; rowNum<[self numberOfRowsInSection:[sectionIdx unsignedIntegerValue]]; rowNum++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNum inSection:[sectionIdx unsignedIntegerValue]];
            [allRowsIndexPaths addObject:indexPath];
        }
    }
    return allRowsIndexPaths;
}

@end
