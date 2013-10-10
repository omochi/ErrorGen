//
//  OMEHandError.m
//  ErrorGen
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OMEHandError.h"

NSString * const OMEHErrorDomain = @"com.omochimetaru.OMEH.ErrorDomain";

NSString * OMEHErrorCodeDescription(OMEHErrorCode code){
	switch (code) {
		case OMEHErrorNoError: return @"no error";
		case OMEHErrorInvalidArgument: return @"invalid argument";
		case OMEHErrorInvalidState: return @"invalid state";
		case OMEHErrorCancelled: return @"cancelled";
		default: @throw [NSException exceptionWithName:NSGenericException reason:@"invalid error code" userInfo:nil];
	}
}

NSError * OMEHErrorMake(OMEHErrorCode code,NSError * causer,NSString * format,...){
	va_list ap;
	va_start(ap, format);
	NSError * error = OMEHErrorMakev(code, causer, format, ap);
	va_end(ap);
	return error;
}

NSError * OMEHErrorMakev(OMEHErrorCode code,NSError * causer,NSString * format,va_list ap){
	NSString * desc = OMEHErrorCodeDescription(code);
	if(format) desc = [NSString stringWithFormat:@"%@: %@",desc,format];
	desc = [[NSString alloc]initWithFormat:desc arguments:ap];
	
	NSMutableDictionary * info = [[NSMutableDictionary alloc]init];
	if(causer) info[NSUnderlyingErrorKey] = causer;
	if(desc) info[NSLocalizedDescriptionKey] = desc;
	return [[NSError alloc]initWithDomain:OMEHErrorDomain code:code userInfo:info];
}
