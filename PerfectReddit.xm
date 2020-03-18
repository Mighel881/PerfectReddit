#import "PerfectReddit.h"

#import <Cephei/HBPreferences.h>
#import "SparkColourPickerUtils.h"

static HBPreferences *pref;
static BOOL disablePromotions;
static BOOL disableSuggestions;
static BOOL customTheme;
static UIColor *mainColor;
static UIColor *secondaryColor;
static UIColor *textColor;

%group disablePromotionsGroup

	%hook Post

	- (BOOL)isHidden
	{
		if([self isKindOfClass:[%c(AdPost) class]])
		{
			return YES;
		}
		return %orig;
	}

	%end

%end

%group disableSuggestionsGroup

	%hook Carousel

	- (_Bool)isHiddenByUserWithAccountSettings:(id)arg1
	{
		return YES;
	}

	%end

%end

%group customThemeGroup

	%hook MintTheme

	// ------------------------------- MAIN COLOR -------------------------------

	- (id)inactiveColor
	{
		return mainColor;
	}

	- (id)logoColor
	{
		return mainColor;
	}

	- (id)activeColor
	{
		return mainColor;
	}

	- (id)buttonColor
	{
		return mainColor;
	}

	- (id)shareSheetDimmerColor
	{
		return mainColor;
	}

	- (id)dimmerColor
	{
		return mainColor;
	}

	- (id)toastColor
	{
		return mainColor;
	}

	- (id)actionColor
	{
		return mainColor;
	}

	- (id)lineColor
	{
		return mainColor;
	}

	- (id)navIconColor
	{
		return mainColor;
	}

	// ------------------------------- SECONDARY-LIGHT COLOR -------------------------------
	- (id)canvasColor
	{
		return secondaryColor;
	}

	- (id)fieldColor
	{
		return secondaryColor;
	}

	- (id)buttonHighlightTextColor
	{
		return secondaryColor;
	}

	- (id)cellHighlightColor
	{
		return secondaryColor;
	}

	- (id)highlightColor
	{
		return secondaryColor;
	}

	- (id)listBackgroundColor
	{
		return secondaryColor;
	}

	- (id)loadingPlaceHolderColor
	{
		return secondaryColor;
	}

	// ------------------------------- TEXT-DARK COLOR -------------------------------
	- (id)bodyTextColor
	{
		return textColor;
	}

	- (id)buttonTextColor
	{
		return textColor;
	}

	- (id)linkTextColor
	{
		return textColor;
	}

	- (id)metaTextColor
	{
		return textColor;
	}

	- (id)flairTextColor
	{
		return textColor;
	}

	%end

%end

%ctor
{
	@autoreleasepool
	{
		pref = [[HBPreferences alloc] initWithIdentifier: @"com.johnzaro.perfectredditprefs"];

		disablePromotions = [pref boolForKey: @"disablePromotions"];
		disableSuggestions = [pref boolForKey: @"disableSuggestions"];
		customTheme = [pref boolForKey: @"customTheme"];

		if(disablePromotions) %init(disablePromotionsGroup);
		if(disableSuggestions) %init(disableSuggestionsGroup);
		if(customTheme)
		{
			NSDictionary *preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/com.johnzaro.perfectredditprefs.colors.plist"];
			
			mainColor = [SparkColourPickerUtils colourWithString: [preferencesDictionary objectForKey: @"mainColor"] withFallback: @"#FF9400"];
			secondaryColor = [SparkColourPickerUtils colourWithString: [preferencesDictionary objectForKey: @"secondaryColor"] withFallback: @"#FFFAE6"];
			textColor = [SparkColourPickerUtils colourWithString: [preferencesDictionary objectForKey: @"textColor"] withFallback: @"#663B00"];
			
			%init(customThemeGroup);
		}
	}
}