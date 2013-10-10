//
//  OMEViewController.m
//  ErrorGenSample
//
//  Created by おもちメタル on 2013/10/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OMEViewController.h"

#import "OMEError.h"
#import "OMEHandError.h"

@interface OMEViewController ()

@end

@implementation OMEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	NSError * error;
	
	NSString * hoge = [self hogehogeWithFile:@"xxxxx" error:&error];
	if(!hoge){
		NSLog(@"error:\n%@",OMEErrorDump(error));
	}
}

- (NSString *)hogehogeWithFile:(NSString *)file error:(NSError * __autoreleasing *)error{
	NSString * s = [[NSString alloc]initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:error];
	if(!s){
		if(error) *error = OMEHErrorMake(OMEHErrorInvalidArgument, *error, @"string load failed: %@",file);
		return nil;
	}
	return [NSString stringWithFormat:@"hogehoge%@",s];
}


@end
