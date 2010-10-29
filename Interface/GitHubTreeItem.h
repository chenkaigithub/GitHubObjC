//
//  GitHubTreeItem.h
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/29/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GitHubTreeItem <NSObject>

@property (readonly, copy) NSString *name;
@property (readonly, copy) NSString *sha;
@property (readonly, copy) NSString *type;
@property (readonly, copy) NSString *mode;
@property (readonly, copy) NSString *mime;
@property (readonly, assign) NSUInteger size;


@end
