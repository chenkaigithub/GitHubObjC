//
//  GitHubRepositoryImp.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubRepository.h"

@interface GitHubRepositoryImp : NSObject <GitHubRepository> {
  int watchers;
  BOOL hasDownloads;
  NSString *desc;
  NSString *name;
  BOOL fork;
  BOOL hasWiki;
  BOOL hasIssues;
  NSURL *url;
  NSString *owner;
  NSURL *homepage;
  int openIssues;
  BOOL private;
  NSDate *creationDate;
  NSDate *pushDate;
  int forks;
}

+(id<GitHubRepository>)repository;

@end
