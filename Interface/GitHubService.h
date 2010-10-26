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
  GitHubServerInternalError = 1,
  GitHubServerOutOfMemoryError = 2,
  GitHubServerServerError = 3,
  GitHubServerParserError = 4,
  GitHubServerConnectionError = 5,
} GitHubServerError;