//
//  RACDetailViewController.m
//  RACPlayground
//
//  Created by jhmac on 2020/11/19.
//  
//

#import "RACDetailViewController.h"
#import "RACDetailDataDriverProtocol.h"
#import "UIImage+Util.h"
#define DataDriver  LEGORealPort(id<RACDetailDataDriverProtocol>, self.dataDriver)
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.height
@interface RACDetailViewController ()
@property (strong, nonatomic) UIImageView *imgView;


//水印层
@property (nonatomic,strong) CATextLayer * firstTextLayer;
@property (nonatomic,strong) CATextLayer * secondTextLayer;
@property (nonatomic,strong) CATextLayer * thirdTextLayer;
@property (nonatomic,strong) CATextLayer * fourthTextLayer;
@property (nonatomic,strong) CATextLayer * fifthTextLayer;

@property (nonatomic,strong) CATextLayer * sixTextLayer;
@property (nonatomic,strong) CATextLayer * sevenTextLayer;
@property (nonatomic,strong) CATextLayer * eightTextLayer;
@property (nonatomic,strong) CATextLayer * nineTextLayer;
@property (strong, nonatomic) UIView *waterView;
@end

@implementation RACDetailViewController
{
    NSString * waterTxt;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配置当前视图
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
    
    [self showWatermark];
}

#pragma mark - 初始化
- (void)config {
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViews {
    //
    UIImageView *imgview = [UIImageView new];
    self.imgView = imgview;
    self.waterView = self.imgView;
    [self.view addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(400, 400));
    }];
    NSString *imgUrl = @"https://fileserver.iuoooo.com/Jinher.JAP.BaseApp.FileServer.UI/FileManage/GetFile?fileURL=29e54e46-3e17-4ca4-8f03-db71fb8f967d/TempDirectory/42034a45-037d-444e-b375-32d5679c3799_05949A4A-71D4-40F8-ABAC-1568E363EA84.png";
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSString *userAccount = [self protectAccount:@"13522834108"];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:userAccount attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:54.0f weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.25]}];
        UIImage *water = [image addWaterByPattern:attr];
        self.imgView.image = water;
    }];
}
- (NSString *)protectAccount:(NSString *)userAccount {
    NSString *phoneNumRegex1 = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneNum1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex1];
    BOOL isPhone = [phoneNum1 evaluateWithObject:userAccount];
    if (isPhone) {
        userAccount = [userAccount stringByReplacingCharactersInRange:NSMakeRange(3, 7) withString:@"*******"];
    }
    return userAccount;
}


- (void)bindViewData {
    // 双向数据绑定
//    XF_$_(self.textField, text, DataDriver, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, DataDriver, Command)
    
    // load or reset expressPack
//    XF_Define_Weak
//    [RACObserve(self.dataDriver, expressData) subscribeNext:^(NSString *imgUrl) {
//        XF_Define_Strong
//        // 如果有显示数据加载完成
//        if (imgUrl) {
//            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                UIImage *water = [image addWaterByPattern:@"192333****4"];
//                self.imgView.image = water;
//            }];
//        }
//    }];
}


#pragma mark - Change UI State
-(void)showWatermark
{
    waterTxt = @"192*****7";
    [self.view addSubview:self.waterView];
    [self.waterView.layer addSublayer:self.firstTextLayer];
    [self.waterView.layer addSublayer:self.secondTextLayer];
    [self.waterView.layer addSublayer:self.thirdTextLayer];
    [self.waterView.layer addSublayer:self.fourthTextLayer];
    [self.waterView.layer addSublayer:self.fifthTextLayer];
    [self.waterView.layer addSublayer:self.sixTextLayer];
    [self.waterView.layer addSublayer:self.sevenTextLayer];
    [self.waterView.layer addSublayer:self.eightTextLayer];
    [self.waterView.layer addSublayer:self.nineTextLayer];
}

#pragma mark - UIControlDelegate


#pragma mark - Getter
-(CATextLayer *)firstTextLayer{
    
    if (!_firstTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        
        _firstTextLayer = [self createTextLayerWithFrame:CGRectMake(-orginX*4, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH + orginX*2, 36)];
    }
    return _firstTextLayer;
}

-(CATextLayer *)secondTextLayer{
    
    if (!_secondTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _secondTextLayer = [self createTextLayerWithFrame:CGRectMake(-orginX*2, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH+orginX, 36)];
    }
    return _secondTextLayer;
}

-(CATextLayer *)thirdTextLayer{
    
    if (!_thirdTextLayer) {
        _thirdTextLayer = [self createTextLayerWithFrame:CGRectMake(0, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH, 36)];
    }
    return _thirdTextLayer;
}

-(CATextLayer *)fourthTextLayer{
    
    if (!_fourthTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _fourthTextLayer = [self createTextLayerWithFrame:CGRectMake(orginX, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH + orginX, 36)];
    }
    return _fourthTextLayer;
}

-(CATextLayer *)fifthTextLayer{
    
    if (!_fifthTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _fifthTextLayer = [self createTextLayerWithFrame:CGRectMake(orginX*3, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH, 36)];
    }
    return _fifthTextLayer;
}

- (CATextLayer *)sixTextLayer{
    if (!_sixTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _sixTextLayer = [self createTextLayerWithFrame:CGRectMake(-orginX*3, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH + orginX*1.5, 36)];
    }
    return _sixTextLayer;
}

-(CATextLayer *)sevenTextLayer{
    if (!_sevenTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _sevenTextLayer = [self createTextLayerWithFrame:CGRectMake(-orginX, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH+orginX/2, 36)];
    }
    return _sevenTextLayer;
}

-(CATextLayer *)eightTextLayer{
    if (!_eightTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _eightTextLayer = [self createTextLayerWithFrame:CGRectMake(orginX/2, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH+ orginX/2, 36)];
    }
    return _eightTextLayer;
}

-(CATextLayer *)nineTextLayer{
    if (!_nineTextLayer) {
        CGFloat orginX = SCREENWIDTH/5;
        _nineTextLayer = [self createTextLayerWithFrame:CGRectMake(orginX*2, (self.waterView.frame.size.height - 36) / 2, SCREENWIDTH+ orginX/2, 36)];
    }
    return _nineTextLayer;
}

- (CATextLayer *)createTextLayerWithFrame:(CGRect)layerFrame{
    CATextLayer * textLayer = [[CATextLayer alloc] init];
    textLayer.frame = layerFrame;
    textLayer.string = [[NSAttributedString alloc] initWithString:waterTxt attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor redColor]}];
    textLayer.alignmentMode = @"left";
    textLayer.opacity = 0.2;
    textLayer.wrapped = YES;
    textLayer.anchorPoint = CGPointMake(0.5, 0.5);
    [textLayer setAffineTransform:CGAffineTransformMakeRotation(-M_PI / 4)];
    return textLayer;
}
@end
