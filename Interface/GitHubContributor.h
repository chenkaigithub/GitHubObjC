//
//  GitHubContributor.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/15/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubContributor <NSObject>

@property (copy) NSString *name;
@property (assign) NSInteger contributions;

@end
