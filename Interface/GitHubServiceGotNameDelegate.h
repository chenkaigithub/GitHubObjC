//
//  GitHubServiceGotNameDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubServiceDelegate;
@protocol GitHubService;

@protocol GitHubServiceGotNameDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
             gotName:(NSString *)name;

@end
