//
//  OMEError.m
//  ErrorGen
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OMEError.h"

NSString * OMEErrorDump(NSError * error){
	NSMutableArray * lines = [NSMutableArray array];
	while(error){
		NSMutableArray * strs = [NSMutableArray array];
		
		[strs addObject:error.domain];
		[strs addObject:[NSString stringWithFormat:@"0x%04x",error.code]];
		
		if([error localizedDescription]){
			[strs addObject:[error localizedDescription]];
		}
		if([error localizedFailureReason]){
			[strs addObject:[error localizedFailureReason]];
		}
		if([error localizedRecoverySuggestion]){
			[strs addObject:[error localizedRecoverySuggestion]];
		}
		[lines addObject:[strs componentsJoinedByString:@": "]];
		error = error.userInfo[NSUnderlyingErrorKey];
	}
	return [lines componentsJoinedByString:@"\n"];
}

BOOL OMEErrorIs(NSError * error,NSString * domain,NSInteger code){
	return [error.domain isEqualToString:domain] && error.code == code;
}