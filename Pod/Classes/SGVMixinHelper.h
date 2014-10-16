//
//  SGVMixinHelper.h
//  SGVAttributedNavigationBarTitle
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGVMixinHelper : NSObject

+ (Class)classWithName:(NSString *)className
 createdByInheritingFromClass:(Class __unsafe_unretained)parent
andMixingInMethodsFromClass:(Class __unsafe_unretained)anotherClass;

@end
