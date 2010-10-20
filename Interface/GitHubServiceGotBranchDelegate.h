//
//  GitHubServiceGotBranchDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubBranch;
@protocol GitHubServiceDelegate;

@protocol GitHubServiceGotBranchDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
           gotBranch:(id<GitHubBranch>)branch;

@end
