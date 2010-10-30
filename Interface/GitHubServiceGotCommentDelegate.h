//
//  GitHubServiceGotCommentDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"
#import "GitHubComment.h"

@protocol GitHubServiceGotCommentDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
          gotComment:(id<GitHubComment>)comment;

@end
