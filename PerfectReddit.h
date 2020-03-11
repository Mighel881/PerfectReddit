#import <Cephei/HBPreferences.h>
#import "SparkColourPickerUtils.h"

HBPreferences *_Nullable pref;

BOOL disablePromotions;
BOOL disableSuggestions;
BOOL customTheme;

NSString *_Nullable mainColorString;
NSString *_Nullable secondaryColorString;
NSString *_Nullable textColorString;

UIColor *_Nullable mainColor;
UIColor *_Nullable secondaryColor;
UIColor *_Nullable textColor;

@interface Post: NSObject
- (BOOL)isHidden;
@end