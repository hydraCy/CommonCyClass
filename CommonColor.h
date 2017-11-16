//
//  CommonColor.h
//  LightningLawyer
//
//  Created by 蔡宇 on 16/12/27.
//  Copyright © 2016年 应续材. All rights reserved.
//

#import <Foundation/Foundation.h>

//屏幕比例适配
#define ScaleWidth [UIScreen mainScreen].bounds.size.width / 375
#define ScaleHeight [UIScreen mainScreen].bounds.size.height / 667
//屏幕适配
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



/**
  十六进制获取颜色
 */
@interface CommonColor : NSObject
UIColor* getColor(NSString * hexColor);

@end
