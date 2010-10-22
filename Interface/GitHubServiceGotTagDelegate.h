//
//  GitHubServiceGotTagDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/19/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"

@protocol GitHubTag;

@protocol GitHubServiceGotTagDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
              gotTag:(id<GitHubTag>)tag;

@end
