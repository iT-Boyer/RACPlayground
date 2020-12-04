//
//  JHSearchCountHeaderView.h
//  RACPlayground
//
//  Created by jhmac on 2020/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHSearchCountHeaderView : UIView
//刷新数据
-(void)refreshStatus:(NSString *)status count:(NSString *)count;
@end

NS_ASSUME_NONNULL_END
