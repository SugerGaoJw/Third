//
//  AppXIBHandlerHeader.h
//  EasyFoodApp
//
//  Created by Suger on 15-6-29.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#ifndef EasyFoodApp_AppXIBHandlerHeader_h
#define EasyFoodApp_AppXIBHandlerHeader_h

/*!
 *  redefine -> self.easyFoodStoryboard
 */
//-------------------------------------------------------------

#define KStoryboard self.mainStoryboard

//-------------------------------------------------------------


/*!
 *  Declare variable
 *
 *  @param  __className description
 *
 *  @return return value description
 */
//-------------------------------------------------------------

#define gxloaderHeader( __className )                     \
NSWeakReadonly __className* gxl##__className;             \

//-------------------------------------------------------------



/*!
 *  Realization method
 *
 *  @param  __className description
 *
 *  @return return value description
 */
//-------------------------------------------------------------

#define gxloaderMethod( __className )                     \
- (__className *) gxl##__className {                      \
    NSString* _classToSID = [NSString stringWithFormat:@"%@SID",NSStringFromClass([__className class])]; \
    return [KStoryboard instantiateViewControllerWithIdentifier:_classToSID];\
}\

//-------------------------------------------------------------


#endif
