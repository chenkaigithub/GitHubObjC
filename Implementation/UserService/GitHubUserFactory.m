//
//  GitHubUserFactory.m
//  GitHubLib
//
//  Created by Magnus Ernstsson on 10/3/10.
//  Copyright 2010 Patchwork Solutions AB. All rights reserved.
//

#import "GitHubUserFactory.h"

@implementation GitHubUserFactory

#pragma mark -
#pragma mark Memory and member management

//Retain
@synthesize user;

-(void)cleanUp {
  self.user = nil;
  [super cleanUp];
}

-(void)dealloc {
  [self cleanUp];
  [super dealloc];
}

#pragma mark -
#pragma mark Delegate protocol implementation
#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict {
  
  if ([elementName isEqualToString:@"user"]) {
    
    self.user = [GitHubUserImp user];
  }
  self.currentStringValue = [NSMutableString stringWithCapacity:100];
}

-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName {
  
  if ([elementName isEqualToString:@"user"]) {
    
    [(id<GitHubServiceGotUserDelegate>)self.delegate gitHubService:self
                                                           gotUser:self.user];
    
  } else if ([elementName isEqualToString:@"name"]) {
    
    self.user.name = currentStringValue;
    
  } else if ([elementName isEqualToString:@"gravatar-id"]) {
    
    self.user.gravatarId = currentStringValue;
    
  } else if ([elementName isEqualToString:@"company"]) {
    
    self.user.company = currentStringValue;
    
  } else if ([elementName isEqualToString:@"location"]) {
    self.user.location = currentStringValue;
    
  } else if ([elementName isEqualToString:@"blog"]) {
    
    NSURL *url = [NSURL URLWithString:currentStringValue];
    
    if (!url.scheme) {
      
       url = [NSURL
              URLWithString:[NSString stringWithFormat:@"http://%@",
                             currentStringValue]];
    }
    self.user.blog = url;
    
  } else if ([elementName isEqualToString:@"email"]) {
    
    self.user.email = currentStringValue;
    
  } else if ([elementName isEqualToString:@"login"]) {
    
    self.user.login = currentStringValue;
    
  } else if ([elementName isEqualToString:@"id"]) {
    
    self.user.ID = currentStringValue;
    
  } else if ([elementName isEqualToString:@"created-at"]) {
    
    if ([self.currentStringValue length] > 18) {
      
      NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
      [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
      
      self.user.creationDate = 
      [formatter dateFromString:[self.currentStringValue substringToIndex:18]];
    }
    
  } else if ([elementName isEqualToString:@"public-repo-count"]) {
    
    self.user.publicRepoCount = [currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"public-gist-count"]) {
    
    self.user.publicGistCount = [currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"following-count"]) {
    
    self.user.followingCount = [currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"followers-count"]) {
    
    self.user.followersCount = [currentStringValue intValue];
    
  } else if ([elementName isEqualToString:@"type"]) {
    
    self.user.type = currentStringValue;
    
  } else if ([elementName isEqualToString:@"error"]) {
    
    [self handleErrorWithCode:GitHubServerServerError];
  }
  self.currentStringValue = nil;
}

#pragma mark -
#pragma mark Interface implementation
#pragma mark - Class

+(GitHubUserFactory *)userFactoryWithDelegate:
(id<GitHubServiceGotUserDelegate>)delegate {
  
  return [[[GitHubUserFactory alloc] initWithDelegate:delegate] autorelease]; 
}

#pragma mark - Instance

-(void)requestUserByName:(NSString *) name {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/user/show/%@",
                     [GitHubBaseFactory serverAddress], name]];
}

-(void)requestUserByEmail:(NSString *) email {
  
  [self makeRequest:[NSString
                     stringWithFormat:@"%@/api/v2/xml/user/email/%@",
                     [GitHubBaseFactory serverAddress], email]];
}

@end
