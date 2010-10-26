//
//  GitHubRef.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/25/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GitHubRef <NSObject>

@property (retain) NSString *name;
@property (retain) NSString *commitId;
@property (retain) NSString *repositoryName;
@property (retain) NSString *userName;

@end
