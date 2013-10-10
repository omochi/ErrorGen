//
//  OMEHandError.h
//  ErrorGen
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

//手書きでエラーを実装する

#import <Foundation/Foundation.h>

extern NSString * const OMEHErrorDomain;

typedef enum OMEHErrorCode {
	OMEHErrorNoError = 0,
	OMEHErrorInvalidArgument,
	OMEHErrorInvalidState,
	OMEHErrorCancelled,
} OMEHErrorCode;

NSString * OMEHErrorCodeDescription(OMEHErrorCode code);

NSError * OMEHErrorMake(OMEHErrorCode code,NSError * causer,NSString * format,...) NS_FORMAT_FUNCTION(3, 4);
NSError * OMEHErrorMakev(OMEHErrorCode code,NSError * causer,NSString * format,va_list ap) NS_FORMAT_FUNCTION(3, 0);