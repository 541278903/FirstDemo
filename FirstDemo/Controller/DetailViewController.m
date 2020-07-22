//
//  DetailViewController.m
//  FirstDemo
//
//  Created by edward on 2020/7/22.
//  Copyright © 2020 com.Edward. All rights reserved.
//

#import "DetailViewController.h"
#import <Masonry/Masonry.h>

@interface DetailViewController ()
//@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) EnterDetailView *nameView;
@property(nonatomic,strong) EnterDetailView *guigeView;
@property(nonatomic,strong) EnterDetailView *jinhuoView;
@property(nonatomic,strong) EnterDetailView *shoujiaView;
@property(nonatomic,strong) EnterDetailView *shuliangView;
@property(nonatomic,strong) T_CS_Entity *entity;
@end

@implementation DetailViewController

- (instancetype)initWithEntity:(T_CS_Entity *)entity
{
    self = [super init];
    if (self) {
        self.entity = entity;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}
-(void)setup{
    [self.view addSubview:self.nameView];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(KTOP_MARGIN);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.guigeView];
    [self.guigeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.nameView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.jinhuoView];
    [self.jinhuoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.guigeView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.shoujiaView];
    [self.shoujiaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.jinhuoView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.shuliangView];
    [self.shuliangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.shoujiaView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
}
- (T_CS_Entity *)entity
{
    if(!_entity)
    {
        T_CS_Entity *x = [[T_CS_Entity alloc]init];
        _entity = x;
    }
    return _entity;
}
- (EnterDetailView *)nameView
{
    if(!_nameView)
    {
        EnterDetailView *x = [[EnterDetailView alloc]init];
        x.titleLabel.text = @"商品名称";
        x.textField.text = self.entity.c_name;
        _nameView = x;
    }
    return _nameView;
}- (EnterDetailView *)guigeView
{
    if(!_guigeView)
    {
        EnterDetailView *x = [[EnterDetailView alloc]init];
        x.titleLabel.text = @"商品规格";
        x.textField.text = self.entity.c_guige;
        _guigeView = x;
    }
    return _guigeView;
}
- (EnterDetailView *)jinhuoView
{
    if(!_jinhuoView)
    {
        EnterDetailView *x = [[EnterDetailView alloc]init];
        x.titleLabel.text = @"商品进货价";
        x.textField.text = self.entity.c_jinhuo;
        _jinhuoView = x;
    }
    return _jinhuoView;
}
- (EnterDetailView *)shoujiaView
{
    if(!_shoujiaView)
    {
        EnterDetailView *x = [[EnterDetailView alloc]init];
        x.titleLabel.text = @"商品售货价";
        x.textField.text = self.entity.c_shouhuo;
        _shoujiaView = x;
    }
    return _shoujiaView;
}
- (EnterDetailView *)shuliangView
{
    if(!_shuliangView)
    {
        EnterDetailView *x = [[EnterDetailView alloc]init];
        x.titleLabel.text = @"商品数量";
        x.textField.text = self.entity.c_shuliang;
        _shuliangView = x;
    }
    return _shuliangView;
}
@end
