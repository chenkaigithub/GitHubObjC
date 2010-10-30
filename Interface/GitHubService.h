//
//  GitHubService.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubService <NSObject>

-(void)cancelRequest;

@end

extern NSString * const GitHubServerErrorDomain;

typedef enum {
  GitHubServerServerError = 1,
  GitHubServerParserError = 2,
  GitHubServerConnectionError = 3,
} GitHubServerError;