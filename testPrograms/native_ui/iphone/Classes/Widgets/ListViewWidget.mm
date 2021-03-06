/*
Copyright (C) 2010 MoSync AB

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

//
//  ListViewWidget.mm
//  nativeuitest
//
//  Created by Niklas Nummelin on 11/26/10.
//

#import "ListViewWidget.h"
#import "ListViewItemWidget.h"

#ifndef NATIVE_TEST
#include "Platform.h"
#include <helpers/cpp_defs.h>
#include <helpers/CPP_IX_WIDGET.h>
#endif

@implementation ListViewWidget

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	NSInteger index = [indexPath row];
	
	NSLog(@"ListItem %d pressed!", index);
#ifndef NATIVE_TEST
	MAEvent event;
	event.type = EVENT_TYPE_WIDGET;
	MAWidgetEventData *eventData = new MAWidgetEventData;
	eventData->eventType = WIDGET_EVENT_ITEM_CLICKED;
	eventData->widgetHandle = handle;
	eventData->listItemIndex = index;
	event.data = eventData;
	Base::gEventQueue.put(event);
#endif
	
}

- (id)init {
	tableView = [[MoSyncTableView alloc] init];
	view = tableView.tableView;	
	
//	[view addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	tableView.tableView.delegate = self;
	id obj = [super init];		
	
	return obj;
}

- (void)addChild: (IWidget*)child {
	if([child class] != [ListViewItemWidget class]) {
		ListViewItemWidget* lvcw = [[ListViewItemWidget alloc] init];
		[lvcw addChild:child];
		child = lvcw;
	}
	
	[tableView addView: [child getView]];
	[view reloadData];
}

- (void)removeChild: (IWidget*)child {
}

- (int)setPropertyWithKey: (NSString*)key toValue: (NSString*)value {

	return [super setPropertyWithKey:key toValue:value];
}

- (NSString*)getPropertyWithKey: (NSString*)key {
	
	return [super getPropertyWithKey:key];
}

@end
