//
//  STableViewHeader.h
//  SUITool
//
//  Created by Suger on 15/8/27.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#ifndef SUITool_STableViewHeader_h
#define SUITool_STableViewHeader_h

/*!
 *  添加刷新控件
 */
typedef NS_ENUM(NSInteger, ENRefreshType){
    /*!
     *  添加头部刷新和尾部刷新 【default】
     */
    ENRefreshAllType    = 0,
    /*!
     *  不添加刷新控件
     */
    ENRefreshNoneType,
    /*!
     *  添加头部刷新
     */
    ENRefreshOnlyHeaderType,
    
};

/*!
 *  TableView In 类型
 */
typedef NS_ENUM(NSInteger, ENTableViewType){
    /*!
     *  TableView In Controller【default】
     */
    ENTableViewInControllerType    = 0,
    /*!
     *  TableView In Tab
     */
    ENTableViewInTabType,
};

/*!
 *  刷新控件状态
 */
typedef NS_ENUM(NSInteger, ENRefreshStateType){
    /*!
     *  头部刷新控件刷新【default】
     */
    ENRefreshHeaderStateType    = 0,
    /*!
     *  尾部刷新控件刷新
     */
    ENRefreshFooterStateType,
};



#endif
