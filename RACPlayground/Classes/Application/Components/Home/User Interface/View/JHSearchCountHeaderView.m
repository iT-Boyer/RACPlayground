
//  JHSearchCountHeaderView.m
//  RACPlayground
//
//  Created by jhmac on 2020/12/4.
//

#import "JHSearchCountHeaderView.h"

@implementation JHSearchCountHeaderView
{
    UILabel *_statuLab;
    UILabel *_countLab;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    UILabel *status = [UILabel new];
    UILabel *count = [UILabel new];
    UIView  *line = [UIView new];
    status.text = @"全部";
    count.text = @"0";
    _statuLab = status;
    _countLab = count;
    UIView *leftView = [self addViewStyle:@"企业状态" view:status];
    UIView *rightView = [self addViewStyle:@"企业数量" view:count];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:leftView];
    [self addSubview:rightView];
    [self addSubview:line];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 90));
    }];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(@-5);
        make.left.equalTo(@20);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(@-5);
        make.right.equalTo(@-20);
        make.left.equalTo(leftView.mas_right).offset(20);
        make.width.equalTo(leftView.mas_width);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.equalTo(@0);
        make.height.equalTo(@10);
        make.bottom.equalTo(@0);
    }];

}

-(void)refreshStatus:(NSString *)status count:(NSString *)count
{
    if ([status isEqualToString:@"异常"]) {
//        _statuLab.textColor = Color_DE354B;
    }
    _statuLab.text = status;
    _countLab.text = count;
}

-(UIView *)addViewStyle:(NSString *)name view:(UILabel *)txtLab
{
    UIView *view = [UIView new];
    txtLab.textAlignment = NSTextAlignmentCenter;
    txtLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
//    count.textColor = Color_04A173;
    //name
    UILabel *lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:12];
//    lab.textColor = Color_5E637B;
    lab.text = name;
    
    [view addSubview:txtLab];
    [view addSubview:lab];
    
    [txtLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];

    [lab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(@0);
        make.top.equalTo(txtLab.mas_bottom).offset(10);
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
    }];

    return view;
}
@end
