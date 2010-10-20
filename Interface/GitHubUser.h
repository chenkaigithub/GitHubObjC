//
//  GitHubUser.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 9/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubUser <NSObject>

@property (copy) NSString *location;
@property (copy) NSString *name;
@property (copy) NSString *login;
@property (copy) NSString *email;
@property (retain) NSURL *blog;
@property (copy) NSString *company;
@property (copy) NSString *gravatarId;
@property (assign) int publicRepoCount;
@property (assign) int publicGistCount;
@property (assign) int followersCount;
@property (assign) int followingCount;
@property (copy) NSDate *creationDate;
@property (copy) NSString *ID;
@property (copy) NSString *type;

-(NSComparisonResult)compare:(id<GitHubUser>)otherUser;

@end
