//
//  RACDogModel.h
//  RACPlayground
//
//  Created by iTBoyer on 2020/11/15.
//
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface RACDogModel : JSONModel
@property (strong, nonatomic) NSArray *message;
@property (strong, nonatomic) NSString *status;
@end

NS_ASSUME_NONNULL_END
