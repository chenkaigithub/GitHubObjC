//
//  GitHubServiceGotContributorDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubContributor;
@protocol GitHubServiceDelegate;

@protocol GitHubServiceGotContributorDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
      gotContributor:(id<GitHubContributor>)contributor;

@end
