//
//  GitHubServiceGotUserDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubUser;
@protocol GitHubServiceDelegate;

@protocol GitHubServiceGotUserDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
             gotUser:(id<GitHubUser>)user;

@end
