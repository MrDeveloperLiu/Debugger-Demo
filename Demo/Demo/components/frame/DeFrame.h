//
//  DeFrame.h
//  Demo
//
//  Created by 刘杨 on 2020/1/22.
//  Copyright © 2020 liu. All rights reserved.
//

#ifndef DeFrame_h
#define DeFrame_h

//Screen
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
//Nav
#define kStatusBarH             20
#define kNavBarH                44
#define kNavH                   (kStatusBarH + kNavBarH)
//Phone
#define kIphone4Size            ((CGSize){320, 480})
#define kIphone5Size            ((CGSize){320, 568})
#define kIphone6_8Size          ((CGSize){375, 667})
#define kIphone6_8PlusSize      ((CGSize){414, 736})
#define kIphoneXSize            ((CGSize){375, 812})
#define kIphoneXMaxSize         ((CGSize){414, 896})
//Safe Edge
#define kIphoneXEdgeTop         24
#define kIphoneXEdgeBottom      34
//Has Edge
#define kIphoneX (CGSizeEqualToSize(kScreenSize, kIphoneXSize))
#define kIphoneXMax (CGSizeEqualToSize(kScreenSize, kIphoneXMaxSize))
#define kIphoneEdge (kIphoneX || kIphoneXMax)
//Safe T B
#define kIphoneXSafeTop (kIphoneEdge ? kIphoneXEdgeTop: 0)
#define kIphoneXSafeBottom (kIphoneEdge ? kIphoneXEdgeBottom: 0)
//ContentRect
#define kContentRect ((CGRect){0, kNavH, kScreenW, kScreenH - kIphoneXSafeBottom - kNavH})


#endif /* DeFrame_h */
