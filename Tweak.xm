#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WAIndicatorContainerView
{
	//swift var
 	NSInteger unreadCount;
}
@property (nonatomic, copy, readwrite) NSString *text;
@end

%hook WAIndicatorContainerView
-(void)setStateWithPinned:(BOOL)arg1 muted:(BOOL)arg2 mentioned:(BOOL)arg3 unreadCount:(NSInteger)arg4 animated:(BOOL)arg5 isAssignedAgentUnread:(BOOL)arg6 {
	%orig;
	// KVO (class not compliant)
	// [(id)self valueForKey:@"unreadCount"]
	NSInteger _unreadCount = MSHookIvar<NSInteger>((id)self, "unreadCount");
	NSString *unreadCountString = [NSString stringWithFormat: @"%ld", (long)_unreadCount];
	NSArray *mainAppLibrarySubviews = ((UIView*)self).subviews;
	for (UIView* uiview in mainAppLibrarySubviews) {
		if ([uiview isKindOfClass:[UIView class]]) {
			for (UIView* unreadBadgeView in uiview.subviews) {
				if ([unreadBadgeView isKindOfClass:[NSClassFromString(@"MainAppLibrary.UnreadBadgeView") class]] ) {
					for (id unreadBadgeLabel in unreadBadgeView.subviews) {
						//obf class name
						if ([unreadBadgeLabel isKindOfClass:[NSClassFromString(@"_TtC14MainAppLibraryP33_3BC543C6EDB5E5E83A29C80CA418F6EA16UnreadBadgeLabel") class]]) {
							[unreadBadgeLabel setText:unreadCountString];	
						}
					}
				}
			}
		}
	}
	/* hard coded 
	NSLog(@"kuj set got to the right place? %@",((UIView*)self).subviews[0].subviews[3].subviews[0]);
	if ([((UIView*)self).subviews[0] isKindOfClass:[UIView class]] && 
	     [((UIView*)self).subviews[0].subviews[3] isKindOfClass:[NSClassFromString(@"MainAppLibrary.UnreadBadgeView") class]] &&
	     [((UIView*)self).subviews[0].subviews[3].subviews[0] isKindOfClass:[NSClassFromString(@"_TtC14MainAppLibraryP33_3BC543C6EDB5E5E83A29C80CA418F6EA16UnreadBadgeLabel") class]]) 
	{
	    [((UIView*)self).subviews[0].subviews[3].subviews[0] setText:walla];
	} else {
		NSLog(@"kuj error: probaby something was changed in this version. doing nothing.");
	}
	*/
}
%end