/* Copyright (C) 2011 MoSync AB
 
 This program is free software; you can redistribute it and/or modify it under
 the terms of the GNU General Public License, version 2, as published by
 the Free Software Foundation.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; see the file COPYING.  If not, write to the Free
 Software Foundation, 59 Temple Place - Suite 330, Boston, MA
 02111-1307, USA.
 */

#import "ButtonWidget.h"
#include "Platform.h"
#include <helpers/cpp_defs.h>
#include <helpers/CPP_IX_WIDGET.h>
#include <base/Syscall.h>

@implementation ButtonWidget

- (id)init {
	if(!view)
		view = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain]; // TODO: do have to do this (retain)??
	UIButton* button = (UIButton*) view;
	button.contentEdgeInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
	[view addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	return [super init];
}

-(void)buttonPressed {
	NSLog(@"Button pressed!");
	MAEvent event;
	event.type = EVENT_TYPE_WIDGET;
	MAWidgetEventData *eventData = new MAWidgetEventData;
	eventData->eventType = MAW_EVENT_CLICKED;
	eventData->widgetHandle = handle;
	event.data = eventData;
	Base::gEventQueue.put(event);
}

- (void)addChild: (IWidget*)child {
	[super addChild:child];
}

- (int)setPropertyWithKey: (NSString*)key toValue: (NSString*)value {
	if([key isEqualToString:@"text"]) {
		UIButton* button = (UIButton*) view;
		[button setTitle:value forState:UIControlStateNormal];
		[self layout];	
	} else
	if([key isEqualToString:@"fontSize"]) {
		UIButton* button = (UIButton*) view;
		float fontSize = [value floatValue];
		[button setFont:[UIFont boldSystemFontOfSize:fontSize]];
	} else		
	if([key isEqualToString:@"fontColor"]) {
		UIButton* button = (UIButton*) view;
		[button setTitleColor:[UIColor colorWithHexString:value] forState:UIControlStateNormal];
	} else			
	if([key isEqualToString:@"backgroundImage"]) {
		int imageHandle = [value intValue];
		if(imageHandle<=0) return MAW_RES_INVALID_PROPERTY_VALUE;
		UIButton* button = (UIButton*) view;
		Surface* imageResource = Base::gSyscall->resources.get_RT_IMAGE(imageHandle);
		UIImage* image = [UIImage imageWithCGImage:imageResource->image];
		[button setBackgroundImage:image forState:UIControlStateNormal];
	} else {
		return [super setPropertyWithKey:key toValue:value];
	}
	return MAW_RES_OK;	
}

- (NSString*)getPropertyWithKey: (NSString*)key {
	if([key isEqualToString:@"text"]) {
		UIButton* button = (UIButton*) view;
		return button.titleLabel.text;
	} else {
		return [super getPropertyWithKey:key];
	}
}

@end
