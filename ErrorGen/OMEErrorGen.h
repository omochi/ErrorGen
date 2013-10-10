//
//  ErrorGen.h
//  ErrorGen
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#define OMEGenStrCat(a,b) a##b
#define OMEGenName2(ns,name) OMEGenStrCat(ns,name)
#define OMEGenName(name) OMEGenName2(OMEGenNameSpace,name)
#define OMEGenCode OMEGenName(Code)

#import <Foundation/Foundation.h>

extern NSString * const OMEGenName(Domain);

typedef enum OMEGenCode {
#define OMEGenCodeEntry(name,value,desc) OMEGenName(name) value ,
#include OMEGenCodeFile
#undef OMEGenCodeEntry
} OMEGenCode;

NSString * OMEGenName(CodeDescription)(OMEGenCode code);

NSError * OMEGenName(Make)(OMEGenCode code,NSError * causer,NSString * format,...) NS_FORMAT_FUNCTION(3, 4);
NSError * OMEGenName(Makev)(OMEGenCode code,NSError * causer,NSString * format,va_list ap) NS_FORMAT_FUNCTION(3, 0);

#ifdef OMEGenAsSource

NSString * const OMEGenName(Domain) = OMEGenErrorDomain;

NSString * OMEGenName(CodeDescription)(OMEGenCode code){
	switch (code) {
#define OMEGenCodeEntry(name,value,desc) case OMEGenName(name): return desc ;
#include OMEGenCodeFile
#undef OMEGenCodeEntry
		default: @throw [NSException exceptionWithName:NSGenericException reason:@"invalid error code" userInfo:nil];
	}
}

NSError * OMEGenName(Make)(OMEGenCode code,NSError * causer,NSString * format,...){
	va_list ap;
	va_start(ap, format);
	NSError * error = OMEGenName(Makev)(code, causer, format, ap);
	va_end(ap);
	return error;
}

NSError * OMEGenName(Makev)(OMEGenCode code,NSError * causer,NSString * format,va_list ap){
	NSString * desc = OMEGenName(CodeDescription)(code);
	if(format) desc = [NSString stringWithFormat:@"%@: %@",desc,format];
	desc = [[NSString alloc]initWithFormat:desc arguments:ap];
	
	NSMutableDictionary * info = [[NSMutableDictionary alloc]init];
	if(causer) info[NSUnderlyingErrorKey] = causer;
	if(desc) info[NSLocalizedDescriptionKey] = desc;
	return [[NSError alloc]initWithDomain:OMEGenName(Domain) code:code userInfo:info];
}

#endif

#undef OMEGenNameSpace
#undef OMEGenCodeFile
#undef OMEGenAsSource