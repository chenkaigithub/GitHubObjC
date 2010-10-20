//
//  GitHubServiceDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubService;

@protocol GitHubServiceDelegate <NSObject>

-(void)gitHubService:(id<GitHubService>)gitHubService
    didFailWithError:(NSError *)error;

-(void)gitHubServiceDone:(id<GitHubService>)gitHubService;

@end
