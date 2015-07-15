//
//  UserBase.m
//  KTAPP
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UserBase.h"

@implementation UserBase

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    
    [aCoder encodeInteger:_id forKey:@"id" ];
    
    [aCoder encodeObject:_name forKey:@"name"];
 
    [aCoder encodeObject:_address forKey:@"address"];
    
    [aCoder encodeObject:_phone forKey:@"phone"];
    
    [aCoder encodeObject:_telephone forKey:@"telephone"];
    
    [aCoder encodeObject:_status forKey:@"status"];
    
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
    [aCoder encodeObject:_userType forKey:@"userType"];
    
    [aCoder encodeInteger:_resourceId forKey:@"resourceId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    
    _id= [aDecoder decodeObjectForKey:@"sessionId"];
    
    _name= [aDecoder decodeObjectForKey:@"name"];
    
    _address = [aDecoder decodeObjectForKey:@"address"];
    
    _phone= [aDecoder decodeObjectForKey:@"phone"];
    
    _telephone= [aDecoder decodeObjectForKey:@"telephone"];
    
    _status= [aDecoder decodeObjectForKey:@"status"];
    
    _updateTime= [aDecoder decodeObjectForKey:@"updateTime"];
    
   _userType= [aDecoder decodeObjectForKey:@"userType"];
    
    _resourceId= [aDecoder decodeIntegerForKey:@"resourceId"];
    
    return self;
}


@end
