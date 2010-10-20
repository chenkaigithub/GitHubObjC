//
//  GitHubRepository.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/4/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubRepository <NSObject>

@property (assign) int watchers;
@property (assign) BOOL hasDownloads;
@property (copy) NSString *desc;
@property (copy) NSString *name;
@property (assign) BOOL fork;
@property (assign) BOOL hasWiki;
@property (assign) BOOL hasIssues;
@property (retain) NSURL *url;
@property (copy) NSString *owner;
@property (retain) NSURL *homepage;
@property (assign) int openIssues;
@property (assign) BOOL private;
@property (retain) NSDate *creationDate;
@property (retain) NSDate *pushDate;
@property (assign) int forks;

@end
