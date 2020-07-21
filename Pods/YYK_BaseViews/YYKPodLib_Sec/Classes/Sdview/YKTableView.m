//
//  YKTableView.m
//  YYKPodLib_Sec
//
//  Created by edward on 2020/6/26.
//  Copyright © 2020 edward. All rights reserved.
//

#import "YKTableView.h"
#import <Masonry/Masonry.h>
#import <MJExtension/MJExtension.h>

typedef void(^ DoThing)(NSIndexPath *indexPath);

@interface YKTableView()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,copy) DoThing doThing;
@property(nonatomic,strong) YKTableViewConfig *config;

@end

@implementation YKTableView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.height.mas_equalTo(0);
        }];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        self.tableView.frame = frame;
    }
    return self;
}
-(void)addHeaderView
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberofrow = 0;
    if(self.config)
    {
        numberofrow = self.config.itemdic.count;
    }
    return numberofrow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.doThing)
    {
        self.doThing(indexPath);
    }
}

#pragma mark get/set

- (UITableView *)tableView
{
    if(!_tableView)
    {
        UITableView *x = [[UITableView alloc]init];
        x.dataSource = self;
        x.delegate = self;
        x.backgroundColor = UIColor.redColor;
        
        _tableView = x;
    }
    return _tableView;
}


@end


@implementation YKTableViewConfig

- (NSMutableArray *)cells
{
    if(!_cells)
    {
        NSMutableArray *x = [[NSMutableArray alloc]init];
        _cells = x;
    }
    return _cells;
}


//- (NSMutableArray *)itemarr
//{
//    if(!_itemarr)
//    {
//        NSMutableArray *x = [[NSMutableArray alloc]init];
//        _itemarr = x;
//    }
//    return _itemarr;
//}
- (NSMutableDictionary *)itemdic
{
    if(!_itemdic)
    {
        NSMutableDictionary *x = [[NSMutableDictionary alloc]init];
        _itemdic = x;
    }
    return _itemdic;
}

@end
