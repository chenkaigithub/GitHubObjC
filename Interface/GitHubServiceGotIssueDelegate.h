//
//  GitHubGotServiceIssueDelegate.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubServiceDelegate.h"
#import "GitHubIssue.h"

@protocol GitHubServiceGotIssueDelegate <GitHubServiceDelegate>

-(void)gitHubService:(id<GitHubService>)gitHubService
            gotIssue:(id<GitHubIssue>)issue;

@end
