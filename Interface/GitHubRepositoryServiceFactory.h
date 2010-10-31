//
//  GitHubRepositoryServiceFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubService.h"
#import "GitHubServiceGotRepositoryDelegate.h"
#import "GitHubServiceGotContributorDelegate.h"
#import "GitHubServiceGotNameDelegate.h"
#import "GitHubServiceGotTagDelegate.h"
#import "GitHubServiceGotBranchDelegate.h"

/**
 * Service factory class for GitHub repository services.
 */
@interface GitHubRepositoryServiceFactory : NSObject {
}

+(id<GitHubService>)requestRepositoriesInNetworkByName:(NSString *)name
                                                  user:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate;

+(id<GitHubService>)requestRepositoryByName:(NSString *)name
                                       user:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate;

+(id<GitHubService>)requestRepositoriesWatchedByUser:(NSString *)name
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate;

+(id<GitHubService>)requestRepositoriesOwnedByUser:(NSString *)name
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate;

+(id<GitHubService>)searchRepositoriesByName:(NSString *)name 
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate;

+(id<GitHubService>)requestCollaboratorsByName:(NSString *)name
                                          user:(NSString *)user
delegate:(id<GitHubServiceGotNameDelegate>)delegate;

+(id<GitHubService>)requestContributorsByName:(NSString *)name
                                         user:(NSString *)user
delegate:(id<GitHubServiceGotContributorDelegate>)delegate;

+(id<GitHubService>)requestWatchersByName:(NSString *)name
                                     user:(NSString *)user
delegate:(id<GitHubServiceGotNameDelegate>)delegate;

+(id<GitHubService>)requestTagsByName:(NSString *)name
                                 user:(NSString *)user
delegate:(id<GitHubServiceGotTagDelegate>)delegate;

+(id<GitHubService>)requestBranchesByName:(NSString *)name
                                     user:(NSString *)user
delegate:(id<GitHubServiceGotBranchDelegate>)delegate;

@end
