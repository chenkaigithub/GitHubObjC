//
//  GitHubLeaderFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubBaseFactory.h"
#import "GitHubServiceGotNameDelegate.h";

@interface GitHubLeaderFactory : GitHubBaseFactory {
}

-(void)requestLeadersOfUser:(NSString *)name;

+(GitHubLeaderFactory *)leaderFactoryWithDelegate:
(id<GitHubServiceGotNameDelegate>)delegate;

@end
