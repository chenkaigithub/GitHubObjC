//
//  GitHubIssueServiceFactory.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubService.h"
#import "GitHubServiceGotCommentDelegate.h"
#import "GitHubServiceGotIssueDelegate.h"
#import "GitHubServiceGotNameDelegate.h"

@interface GitHubIssueServiceFactory : NSObject {
}

+(id<GitHubService>)
searchIssuesForTerm:(NSString *)term
state:(GitHubIssueState)state
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotIssueDelegate>)delegate;

+(id<GitHubService>)
requestIssuesForState:(GitHubIssueState)State
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotIssueDelegate>)delegate;

+(id<GitHubService>)
requestIssuesForLabel:(NSString *)label
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotIssueDelegate>)delegate;

+(id<GitHubService>)
requestCommentsForNumber:(NSUInteger)number
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotCommentDelegate>)delegate;

+(id<GitHubService>)
requestLabelsForUser:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotNameDelegate>)delegate;

+(id<GitHubService>)
requestIssueForNumber:(NSUInteger)number
user:(NSString *)user
repository:(NSString *)repository
delegate:(id<GitHubServiceGotIssueDelegate>)delegate;

@end
