//
//  ZZFLEXAngel+Private.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/14.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+Private.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewModel.h"

@implementation ZZFLEXAngel (Private)

- (ZZFlexibleLayoutSectionModel *)sectionModelAtIndex:(NSInteger)section
{
    return section < self.data.count ? self.data[section] : nil;
}

- (ZZFlexibleLayoutSectionModel *)sectionModelForTag:(NSInteger)sectionTag
{
    for (ZZFlexibleLayoutSectionModel *sectionModel in self.data) {
        if (sectionModel.sectionTag == sectionTag) {
            return sectionModel;
        }
    }
    return nil;
}

- (ZZFlexibleLayoutViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath) {
        return nil;
    }
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    return [sectionModel objectAtIndex:indexPath.row];
}

- (NSArray<ZZFlexibleLayoutViewModel *> *)viewModelsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (NSIndexPath *indexPath in indexPaths) {
        ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
        if (viewModel) {
            [data addObject:viewModel];
        }
    }
    return data;
}

@end
