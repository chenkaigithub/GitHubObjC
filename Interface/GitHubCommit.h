//
//  GitHubCommit.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubCommit <NSObject>

@property (retain) NSMutableArray *parents;
@property (copy) NSString *authorName;
@property (copy) NSString *authorEmail;
@property (copy) NSString *authorLogin;
@property (retain) NSURL *url;
@property (copy) NSString *commitId;
@property (retain) NSDate *committedDate;
@property (retain) NSDate *authoredDate;
@property (copy) NSString *tree;
@property (copy) NSString *committerName;
@property (copy) NSString *committerLogin;
@property (copy) NSString *committerEmail;
@property (copy) NSString *message;

@end
