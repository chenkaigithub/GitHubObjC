//
//  GitHubRepositoryFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubBaseFactory.h"

@protocol GitHubRepository;
@protocol GitHubServiceGotRepositoryDelegate;

@interface GitHubRepositoryFactory : GitHubBaseFactory {
  id<GitHubRepository> repository;
  BOOL networkElement;
}

@property (retain) id<GitHubRepository> repository;
@property (assign) BOOL networkElement;

-(void)searchRepositoriesByName:(NSString *)name;

-(void)requestRepositoriesInNetworkByName:(NSString *)name
                                     user:(NSString *)user;

-(void)requestRepositoryByName:(NSString *)name
                          user:(NSString *)user;

-(void)requestRepositoriesWatchedByUser:(NSString *)name;

-(void)requestRepositoriesOwnedByUser:(NSString *)name;

+(GitHubRepositoryFactory *)repositoryFactoryWithDelegate:
(id<GitHubServiceGotRepositoryDelegate>)delegate;

@end
