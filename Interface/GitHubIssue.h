//
//  GitHubIssue.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/30/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  GitHubIssueOpen,
  GitHubIssueClosed
} GitHubIssueState;

@protocol GitHubIssue <NSObject>

@property (readonly, copy) NSString *gravatar;
@property (readonly, assign) float position;
@property (readonly, assign) NSUInteger number;
@property (readonly, assign) NSUInteger votes;
@property (readonly, retain) NSDate *created;
@property (readonly, assign) NSUInteger comments;
@property (readonly, copy) NSString *body;
@property (readonly, copy) NSString *title;
@property (readonly, retain) NSDate *updated;
@property (readonly, retain) NSDate *closed;
@property (readonly, copy) NSString *user;
@property (readonly, retain) NSArray *labels;
@property (readonly, assign) GitHubIssueState state;

@end
