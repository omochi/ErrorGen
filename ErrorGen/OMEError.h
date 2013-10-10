//
//  OMEError.h
//  ErrorGen
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString * OMEErrorDump(NSError * error);
BOOL OMEErrorIs(NSError * error,NSString * domain,NSInteger code);