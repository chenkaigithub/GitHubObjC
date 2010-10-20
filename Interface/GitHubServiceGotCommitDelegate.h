//
//  GitHubServiceGotCommitDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubCommit;
@protocol GitHubServiceDelegate;

@protocol GitHubServiceGotCommitDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
           gotCommit:(id<GitHubCommit>)commit;

@end
