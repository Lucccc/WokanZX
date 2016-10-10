//
//  Device.h
//  WokanZX
//
//  Created by Lucccc on 16/9/30.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
"devices": [
            {
                "id": 1,
                "imei": "test00000000001",
                "name": "测试机1号",
                "bind_password": "123456",
                "is_online": "0",
                "stream_id": "z1.reiniot.test00000000001",
                "stream_key": "f8bccebd1d717b39",
                "last_ip": "",
                "created_at": "2016-09-22 09:45:36",
                "updated_at": "2016-09-27 09:50:38",
                "deleted_at": null,
                "pivot": {
                    "user_id": "5",
                    "device_id": "1",
                    "created_at": "2016-09-28 07:35:35",
                    "updated_at": "2016-09-28 07:35:35"
                }
            }
            ]
 
 */
@interface Device : NSObject

@property(nonatomic, copy)NSString *imei;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *is_online;

@property(nonatomic, copy)NSString *snapshot;



@end
