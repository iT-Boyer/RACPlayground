//
//  RACRegisterDataDriverProtocol.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/10.
//  
//


#ifndef RACRegisterDataDriverProtocol_h
#define RACRegisterDataDriverProtocol_h
#import "LEDataDriverProtocol.h"

@protocol RACRegisterDataDriverProtocol <LEDataDriverProtocol>

@property (strong, nonatomic) NSString *userName;
@end

#endif /* RACRegisterDataDriverProtocol_h */
