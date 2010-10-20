//
//  GitHubUserImp.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/1/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubUserImp.h"

@protocol GitHubUser;

@implementation GitHubUserImp

@synthesize gravatarId, company, blog, email, name, login, location, ID, type,
publicRepoCount, publicGistCount, followersCount, followingCount, creationDate;

+(id<GitHubUser>)user {
  return [[[GitHubUserImp alloc] init] autorelease]; 
}

-(NSString *)description {
  return [NSString
          stringWithFormat:@"\nSTART - GitHubUser\n"
          "Name:%@\n"
          "Company:%@\n"
          "Location:%@\n"
          "Login:%@\n"
          "eMail:%@\n"
          "Blog:%@\n"
          "GravatarId:%@\n"
          "PublicGistCount:%i\n"
          "PublicRepoCount:%i\n"
          "FollowersCount:%i\n"
          "FollowingCount:%i\n"
          "CreationDate:%@\n"
          "ID:%@\n"
          "Type:%@\n"
          "END - GitHubUser\n",
          self.name,
          self.company,
          self.location,
          self.login,
          self.email,
          self.blog,
          self.gravatarId,
          self.publicGistCount,
          self.publicRepoCount,
          self.followersCount,
          self.followingCount,
          self.creationDate,
          self.ID,
          self.type];
}

-(NSComparisonResult)compare:(id<GitHubUser>)otherUser {
  return [self.login compare:otherUser.login];
}

-(void)dealloc {
  self.location = nil;
  self.name = nil;
  self.login = nil;
  self.email = nil;
  self.blog = nil;
  self.company = nil;
  self.gravatarId = nil;
  self.creationDate = nil;
  self.ID = nil;
  self.type = nil;
  [super dealloc];
}

@end
