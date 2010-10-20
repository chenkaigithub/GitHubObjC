//
//  GitHubUserImp.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/1/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubUser.h"

@interface GitHubUserImp : NSObject <GitHubUser> {
  NSString *location;
  NSString *name;
  NSString *login;
  NSString *email;
  NSURL *blog;
  NSString *company;
  NSString *gravatarId;
  int publicRepoCount;
  int publicGistCount;
  int followersCount;
  int followingCount;
  NSDate *creationDate;
  NSString *ID;
  NSString *type;
}

+(id<GitHubUser>)user;

@end
