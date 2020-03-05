//
//  TbCell.m
//  FirstDemo
//
//  Created by edward on 2019/10/15.
//  Copyright © 2019 com.Edward. All rights reserved.
//

#import "TbCell.h"
@interface TbCell()


@property(nonatomic,weak)UIImageView *iconimageview;
@property(nonatomic,weak)UILabel *datalabelv;
@property(nonatomic,weak)UILabel *detaillabelv;
@property(nonatomic,weak)UILabel *iscelabel;


@end

@implementation TbCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // reuseIdentifier:复用标识符
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
