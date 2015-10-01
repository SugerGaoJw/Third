//
//  NSPropertyMacro.h
//  EduApp
//
//  Created by Suger on 15-5-1.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#ifndef EduApp_NSPropertyMacro_h
#define EduApp_NSPropertyMacro_h

//normal
#define NSStrong    @property (nonatomic , strong )
#define NSWeak      @property (nonatomic , weak   )
#define NSAssign    @property (nonatomic , assign )
#define NSCopy      @property (nonatomic , copy   )

//read-only
#define NSStrongReadonly    @property (nonatomic, strong,readonly  )
#define NSWeakReadonly      @property (nonatomic, weak,  readonly  )
#define NSAssignReadonly    @property (nonatomic, assign,readonly  )
#define NSCopyReadonly      @property (nonatomic , copy,readonly   )



#endif
