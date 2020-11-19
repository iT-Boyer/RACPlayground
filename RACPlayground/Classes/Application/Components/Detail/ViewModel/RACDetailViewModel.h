//
//  RACDetailViewModel.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/19.
//  
//

#import "LEViewModel.h"
#import "RACDetailDataDriverProtocol.h"

@interface RACDetailViewModel : LEViewModel <RACDetailDataDriverProtocol>
@property (strong, nonatomic) NSString *expressData;
@end
