//
//  TLSearchController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSearchController.h"

@implementation TLSearchController

- (id)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        [self.searchBar setBarTintColor:[UIColor colorSearchBarTint]];
        [self.searchBar setTintColor:[UIColor colorDefaultGreen]];
        [self.searchBar.layer setBorderWidth:BORDER_WIDTH_1PX];
        [self.searchBar.layer setBorderColor:[UIColor colorSearchBarBorder].CGColor];
        UITextField *tf = [[[self.searchBar.subviews firstObject] subviews] lastObject];
        [tf.layer setMasksToBounds:YES];
        [tf.layer setBorderWidth:BORDER_WIDTH_1PX];
        [tf.layer setBorderColor:[UIColor colorCellLine].CGColor];
        [tf.layer setCornerRadius:5.0f];
    }
    return self;
}

- (void)setShowVoiceButton:(BOOL)showVoiceButton
{
    _showVoiceButton = showVoiceButton;
    if (showVoiceButton) {
        [self.searchBar setShowsBookmarkButton:YES];
        [self.searchBar setImage:[UIImage imageNamed:@"searchBar_voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        [self.searchBar setImage:[UIImage imageNamed:@"searchBar_voice_HL"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
    }
    else {
        [self.searchBar setShowsBookmarkButton:NO];
    }
}

@end
