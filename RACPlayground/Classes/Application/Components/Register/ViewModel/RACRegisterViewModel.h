//
//  RACRegisterViewModel.h
//  RACPlayground
//
//  Created by jhmac on 2020/11/10.
//  
//

#import "LEViewModel.h"
#import "RACRegisterDataDriverProtocol.h"

@interface RACRegisterViewModel : LEViewModel <RACRegisterDataDriverProtocol>
@property (strong, nonatomic) NSString *userName;
@end
