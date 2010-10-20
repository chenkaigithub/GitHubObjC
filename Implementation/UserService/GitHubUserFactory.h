//
//  GitHubUserFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/3/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubBaseFactory.h"
#import "GitHubService.h"

@protocol GitHubUser;
@protocol GitHubServiceGotUserDelegate;

@interface GitHubUserFactory : GitHubBaseFactory <GitHubService> {
  id<GitHubUser> user;
}

@property (retain) id<GitHubUser> user;

-(void)requestUserByName:(NSString *)name;

-(void)requestUserByEmail:(NSString *)email;

+(GitHubUserFactory *)userFactoryWithDelegate:
(id<GitHubServiceGotUserDelegate>)delegate;

@end
