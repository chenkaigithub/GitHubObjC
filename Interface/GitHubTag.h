//
//  GitHubTag.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/16/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubTag <NSObject>

@property (retain) NSString *name;
@property (retain) NSString *commitId;
@property (retain) NSString *repositoryName;
@property (retain) NSString *userName;

@end
