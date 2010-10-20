//
//  GitHubCommitImp.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubCommit.h"

@interface GitHubCommitImp : NSObject <GitHubCommit> {
  NSMutableArray *parents;
  NSString *authorName;
  NSString *authorEmail;
  NSString *authorLogin;
  NSURL *url;
  NSString *commitId;
  NSDate *committedDate;
  NSDate *authoredDate;
  NSString *tree;
  NSString *committerName;
  NSString *committerLogin;
  NSString *committerEmail;
  NSString *message;
}

+(id<GitHubCommit>)commit;

@end
