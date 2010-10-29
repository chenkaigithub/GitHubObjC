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
  NSMutableArray *added;
  NSMutableArray *modified;
  NSMutableArray *modifiedDiff;
  NSMutableArray *removed;
}

@property (retain) NSArray *parents;
@property (copy) NSString *authorName;
@property (copy) NSString *authorEmail;
@property (copy) NSString *authorLogin;
@property (retain) NSURL *url;
@property (copy) NSString *commitId;
@property (retain) NSDate *committedDate;
@property (retain) NSDate *authoredDate;
@property (copy) NSString *tree;
@property (copy) NSString *committerName;
@property (copy) NSString *committerLogin;
@property (copy) NSString *committerEmail;
@property (copy) NSString *message;
@property (retain) NSArray *added;
@property (retain) NSArray *modified;
@property (retain) NSArray *modifiedDiff;
@property (retain) NSArray *removed;

+(id<GitHubCommit>)commit;

@end
