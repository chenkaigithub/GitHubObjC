//
//  GitHubRepositoryServiceFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright (c) 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubRepositoryServiceFactory.h"
#import "GitHubRepositoryFactory.h"
#import "GitHubCollaboratorFactory.h"
#import "GitHubWatcherFactory.h"
#import "GitHubContributorFactory.h"
#import "GitHubTagFactory.h"
#import "GitHubBranchFactory.h"

@protocol GitHubServiceGotContributorDelegate;
@protocol GitHubServiceGotNameDelegate;
@protocol GitHubServiceGotTagDelegate;
@protocol GitHubServiceGotBranchDelegate;

@implementation GitHubRepositoryServiceFactory

+(id<GitHubService>)requestRepositoriesInNetworkByName:(NSString *)name
                                                  user:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
	GitHubRepositoryFactory *service =
  [GitHubRepositoryFactory
   repositoryFactoryWithDelegate:delegate];
  
	[service requestRepositoriesInNetworkByName:name user:user];
	return service;
}

+(id<GitHubService>)requestRepositoryByName:(NSString *)name
                                       user:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
  GitHubRepositoryFactory *service = [GitHubRepositoryFactory
                                      repositoryFactoryWithDelegate:delegate];
  
	[service requestRepositoryByName:name user:user];
	return service;
}

+(id<GitHubService>)requestRepositoriesWatchedByUser:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
  GitHubRepositoryFactory *service = [GitHubRepositoryFactory
                                      repositoryFactoryWithDelegate:delegate];
  
	[service requestRepositoriesWatchedByUser:user];
	return service;
}

+(id<GitHubService>)requestRepositoriesOwnedByUser:(NSString *)user
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
  GitHubRepositoryFactory *service = [GitHubRepositoryFactory
                                      repositoryFactoryWithDelegate:delegate];
  
	[service requestRepositoriesOwnedByUser:user];
	return service;
}

+(id<GitHubService>)searchRepositoriesByName:(NSString *)name
delegate:(id<GitHubServiceGotRepositoryDelegate>)delegate {
  
  GitHubRepositoryFactory *service = [GitHubRepositoryFactory
                                      repositoryFactoryWithDelegate:delegate];
	[service searchRepositoriesByName:name];
	return service;
}

+(id<GitHubService>)requestCollaboratorsByName:(NSString *)name
                                          user:(NSString *)user
delegate:(id<GitHubServiceGotNameDelegate>)delegate {
  
  GitHubCollaboratorFactory *service =
  [GitHubCollaboratorFactory
   collaboratorFactoryWithDelegate:delegate];
  
	[service requestCollaboratorsByName:name user:user];
	return service;
}

+(id<GitHubService>)requestContributorsByName:(NSString *)name
                                         user:(NSString *)user
delegate:(id<GitHubServiceGotContributorDelegate>)delegate {
  
  GitHubContributorFactory *service = [GitHubContributorFactory
                                       contributorFactoryWithDelegate:delegate];
  
	[service requestContributorsByName:name user:user];
	return service;
}

+(id<GitHubService>)requestWatchersByName:(NSString *)name
                                     user:(NSString *)user
delegate:(id<GitHubServiceGotNameDelegate>)delegate {
  
  GitHubWatcherFactory *service = [GitHubWatcherFactory
                                   watcherFactoryWithDelegate:delegate];
  
	[service requestWatchersByName:name user:user];
	return service;
}

+(id<GitHubService>)requestTagsByName:(NSString *)name
                                 user:(NSString *)user
delegate:(id<GitHubServiceGotTagDelegate>)delegate {
  
  GitHubTagFactory *service = [GitHubTagFactory
                               tagFactoryWithDelegate:delegate];
  
	[service requestTagsByName:name user:user];
	return service;
}

+(id<GitHubService>)requestBranchesByName:(NSString *)name
                                     user:(NSString *)user
delegate:(id<GitHubServiceGotBranchDelegate>)delegate {
  
  GitHubBranchFactory *service = [GitHubBranchFactory
                                  branchFactoryWithDelegate:delegate];
  
	[service requestBranchesByName:name user:user];
	return service;
}

@end
