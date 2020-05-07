//
//  GTListItem.m
//  SampleApp1
//
//  Created by user on 2020/3/6.
//  Copyright © 2020 user. All rights reserved.
//

#import "GTListItem.h"

@implementation GTListItem

#pragma mark - NSSecureCoding

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.source = [coder decodeObjectForKey:@"source"];
        self.ptime = [coder decodeObjectForKey:@"ptime"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.imgsrc = [coder decodeObjectForKey:@"imgsrc"];
        self.replyCount = [coder decodeObjectForKey:@"replyCount"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.source forKey:@"source"];
    [coder encodeObject:self.ptime forKey:@"ptime"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.imgsrc forKey:@"imgsrc"];
    [coder encodeObject:self.replyCount forKey:@"replyCount"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - 对象数据配置


- (void)configWithDictionary:(NSDictionary *)dictionary {
    self.source = [dictionary objectForKey:@"source"];
    self.title = [dictionary objectForKey:@"title"];
    self.ptime = [dictionary objectForKey:@"ptime"];
    self.url = [dictionary objectForKey:@"url"];
    self.imgsrc = [dictionary objectForKey:@"imgsrc"];
    
    id what = [dictionary objectForKey:@"replyCount"];
    NSLog(@"");
    self.replyCount = [what stringValue];
    NSLog(@"");
}

@end
