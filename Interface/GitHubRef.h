//
//  GitHubRef.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/25/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GitHubRef <NSObject>

@property (readonly, retain) NSString *name;
@property (readonly, retain) NSString *commitId;
@property (readonly, retain) NSString *repositoryName;
@property (readonly, retain) NSString *userName;

@end
