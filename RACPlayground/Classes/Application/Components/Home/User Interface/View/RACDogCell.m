//
//  RACDogCell.m
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/18.
//

#import "RACDogCell.h"


@implementation RACDogCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView
{
    //
    UILabel *nameLab = [UILabel new];
    UIImageView *imgView = [UIImageView new];
    
    [self.contentView addSubview:nameLab];
    [self.contentView addSubview:imgView];
    
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(@0);
        make.left.equalTo(imgView.mas_right).offset(10);
    }];

//    RAC(nameLab,)
//    RAC(nameLab,text) = self.
    XF_$_(nameLab, text, self, name)
    XF_Define_Weak
    [RACObserve(self, imgUrl) subscribeNext:^(id x) {
        XF_Define_Strong
        // 如果有显示数据加载完成
        if (x) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:x]];
        }
    }];
}


@end
