//
//  GitHubServiceGotDataDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"

@protocol GitHubServiceGotDataDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
             gotData:(NSString *)data;

@end
