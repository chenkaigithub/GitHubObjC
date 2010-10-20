//
//  GitHubFollowersFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubBaseFactory.h"

@protocol GitHubServiceGotNameDelegate;

@interface GitHubFollowerFactory : GitHubBaseFactory {
}

-(void)requestFollowersOfUser:(NSString *)name;

+(GitHubFollowerFactory *)followerFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate;

@end
