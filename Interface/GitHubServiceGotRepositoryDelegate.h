//
//  GitHubServiceGotRepositoryDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"

@protocol GitHubRepository;

@protocol GitHubServiceGotRepositoryDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
       gotRepository:(id<GitHubRepository>)repository;

@end
