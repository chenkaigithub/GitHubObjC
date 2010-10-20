//
//  GitHubCommitFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubBaseFactory.h"

@protocol GitHubCommit;
@protocol GitHubServiceGotCommitDelegate;

@interface GitHubCommitFactory : GitHubBaseFactory {
  id<GitHubCommit> commit;
  BOOL author;
  BOOL committer;
  BOOL parent;
}

@property (retain) id<GitHubCommit> commit;
@property (assign) BOOL author;
@property (assign) BOOL committer;
@property (assign) BOOL parent;

-(void)requestCommitsOnBranch:(NSString *)branch
                   repository:(NSString *)repository
                         user:(NSString *)user;

-(void)requestCommitsOnBranch:(NSString *)branch
                         path:(NSString *)path
                   repository:(NSString *)repository
                         user:(NSString *)user;

-(void)requestCommit:(NSString *)commitId
          repository:(NSString *)repository
                user:(NSString *)user;

+(GitHubCommitFactory *)commitFactoryWithDelegate:
(id<GitHubServiceGotCommitDelegate>)delegate;

@end
