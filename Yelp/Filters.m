//
//  Filters.m
//  Yelp
//
//  Created by Saker Lin on 2015/6/21.
//  Copyright (c) 2015年 Saker Lin. All rights reserved.
//

#import "Filters.h"

@interface Filters()

@end

@implementation Filters

- (id)initDefault {
    self = [super init];
    if (self) {
        self.setSortBy = @0;
        self.setOfferDeals = NO;
        self.setDistance = @0;
        self.setCategories = [NSMutableSet set];
        
        self.sortBy = @[
                        @{@"key" : @"Best matched", @"value" : @0},
                        @{@"key" : @"Distance", @"value" : @1},
                        @{@"key" : @"Highest Rated", @"value" : @2}
                        ];
        

        self.distances = @[
                           @{@"key" : @"ALL", @"value" : @0},
                           @{@"key" : @"500 m", @"value" : @500},
                           @{@"key" : @"2 km", @"value" : @2000},
                           @{@"key" : @"5 kms", @"value" : @5000},
                           @{@"key" : @"15 kms", @"value" : @15000}
                           ];
        self.filterSections = @[
                                @"Distance",@"Sort By",@"Offering Deals",@"Categories"
                                ];
        
        self.category = @[
                          @{@"key" : @"Pizza", @"code" : @"pizza"},
                          @{@"key" : @"Korean", @"code" : @"korean"},
                          @{@"key" : @"Japanese", @"code" : @"japanese"},
                          @{@"key" : @"Afghan", @"code" : @"afghani"},
                          @{@"key" : @"African", @"code" : @"african"},
                          @{@"key" : @"Senegalese", @"code" : @"senegalese"},
                          @{@"key" : @"South African", @"code" : @"southafrican"},
                          @{@"key" : @"American, New", @"code" : @"newamerican"},
                          @{@"key" : @"American, Traditional", @"code" : @"tradamerican"},
                          @{@"key" : @"Arabian", @"code" : @"arabian"},
                          @{@"key" : @"Argentine", @"code" : @"argentine"},
                          @{@"key" : @"Armenian", @"code" : @"armenian"},
                          @{@"key" : @"Asian Fusion", @"code" : @"asianfusion"},
                          @{@"key" : @"Australian", @"code" : @"australian"},
                          @{@"key" : @"Austrian", @"code" : @"austrian"},
                          @{@"key" : @"Bangladeshi", @"code" : @"bangladeshi"},
                          @{@"key" : @"Barbeque", @"code" : @"bbq"},
                          @{@"key" : @"Basque", @"code" : @"basque"},
                          @{@"key" : @"Belgian", @"code" : @"belgian"},
                          @{@"key" : @"Brasseries", @"code" : @"brasseries"},
                          @{@"key" : @"Brazilian", @"code" : @"brazilian"},
                          @{@"key" : @"Breakfast & Brunch", @"code" : @"breakfast_brunch"},
                          @{@"key" : @"British", @"code" : @"british"},
                          @{@"key" : @"Buffets", @"code" : @"buffets"},
                          @{@"key" : @"Burgers", @"code" : @"burgers"},
                          @{@"key" : @"Burmese", @"code" : @"burmese"},
                          @{@"key" : @"Cafes", @"code" : @"cafes"},
                          @{@"key" : @"Cafeteria", @"code" : @"cafeteria"},
                          @{@"key" : @"Cajun/Creole", @"code" : @"cajun"},
                          @{@"key" : @"Cambodian", @"code" : @"cambodian"},
                          @{@"key" : @"Caribbean", @"code" : @"caribbean"},
                          @{@"key" : @"Dominican", @"code" : @"dominican"},
                          @{@"key" : @"Haitian", @"code" : @"haitian"},
                          @{@"key" : @"Puerto Rican", @"code" : @"puertorican"},
                          @{@"key" : @"Trinidadian", @"code" : @"trinidadian"},
                          @{@"key" : @"Catalan", @"code" : @"catalan"},
                          @{@"key" : @"Cheesesteaks", @"code" : @"cheesesteaks"},
                          @{@"key" : @"Chicken Shop", @"code" : @"chickenshop"},
                          @{@"key" : @"Chicken Wings", @"code" : @"chicken_wings"},
                          @{@"key" : @"Chinese", @"code" : @"chinese"},
                          @{@"key" : @"Cantonese", @"code" : @"cantonese"},
                          @{@"key" : @"Dim Sum", @"code" : @"dimsum"},
                          @{@"key" : @"Shanghainese", @"code" : @"shanghainese"},
                          @{@"key" : @"Szechuan", @"code" : @"szechuan"},
                          @{@"key" : @"Comfort Food", @"code" : @"comfortfood"},
                          @{@"key" : @"Corsican", @"code" : @"corsican"},
                          @{@"key" : @"Creperies", @"code" : @"creperies"},
                          @{@"key" : @"Cuban", @"code" : @"cuban"},
                          @{@"key" : @"Czech", @"code" : @"czech"},
                          @{@"key" : @"Delis", @"code" : @"delis"},
                          @{@"key" : @"Diners", @"code" : @"diners"},
                          @{@"key" : @"Fast Food", @"code" : @"hotdogs"},
                          @{@"key" : @"Filipino", @"code" : @"filipino"},
                          @{@"key" : @"Fish & Chips", @"code" : @"fishnchips"},
                          @{@"key" : @"Fondue", @"code" : @"fondue"},
                          @{@"key" : @"Food Court", @"code" : @"food_court"},
                          @{@"key" : @"Food Stands", @"code" : @"foodstands"},
                          @{@"key" : @"French", @"code" : @"french"},
                          @{@"key" : @"Gastropubs", @"code" : @"gastropubs"},
                          @{@"key" : @"German", @"code" : @"german"},
                          @{@"key" : @"Gluten-Free", @"code" : @"gluten_free"},
                          @{@"key" : @"Greek", @"code" : @"greek"},
                          @{@"key" : @"Halal", @"code" : @"halal"},
                          @{@"key" : @"Hawaiian", @"code" : @"hawaiian"},
                          @{@"key" : @"Himalayan/Nepalese", @"code" : @"himalayan"},
                          @{@"key" : @"Hong Kong Style Cafe", @"code" : @"hkcafe"},
                          @{@"key" : @"Hot Dogs", @"code" : @"hotdog"},
                          @{@"key" : @"Hot Pot", @"code" : @"hotpot"},
                          @{@"key" : @"Hungarian", @"code" : @"hungarian"},
                          @{@"key" : @"Iberian", @"code" : @"iberian"},
                          @{@"key" : @"Indian", @"code" : @"indpak"},
                          @{@"key" : @"Indonesian", @"code" : @"indonesian"},
                          @{@"key" : @"Irish", @"code" : @"irish"},
                          @{@"key" : @"Italian", @"code" : @"italian"},
                          @{@"key" : @"Ramen", @"code" : @"ramen"},
                          @{@"key" : @"Teppanyaki", @"code" : @"teppanyaki"},
                          @{@"key" : @"Kosher", @"code" : @"kosher"},
                          @{@"key" : @"Laotian", @"code" : @"laotian"},
                          @{@"key" : @"Latin American", @"code" : @"latin"},
                          @{@"key" : @"Colombian", @"code" : @"colombian"},
                          @{@"key" : @"Salvadorean", @"code" : @"salvadorean"},
                          @{@"key" : @"Venezuelan", @"code" : @"venezuelan"},
                          @{@"key" : @"Live/Raw Food", @"code" : @"raw_food"},
                          @{@"key" : @"Malaysian", @"code" : @"malaysian"},
                          @{@"key" : @"Mediterranean", @"code" : @"mediterranean"},
                          @{@"key" : @"Falafel", @"code" : @"falafel"},
                          @{@"key" : @"Mexican", @"code" : @"mexican"},
                          @{@"key" : @"Middle Eastern", @"code" : @"mideastern"},
                          @{@"key" : @"Egyptian", @"code" : @"egyptian"},
                          @{@"key" : @"Lebanese", @"code" : @"lebanese"},
                          @{@"key" : @"Modern European", @"code" : @"modern_european"},
                          @{@"key" : @"Mongolian", @"code" : @"mongolian"},
                          @{@"key" : @"Moroccan", @"code" : @"moroccan"},
                          @{@"key" : @"Pakistani", @"code" : @"pakistani"},
                          @{@"key" : @"Persian/Iranian", @"code" : @"persian"},
                          @{@"key" : @"Peruvian", @"code" : @"peruvian"},
                          @{@"key" : @"Polish", @"code" : @"polish"},
                          @{@"key" : @"Portuguese", @"code" : @"portuguese"},
                          @{@"key" : @"Poutineries", @"code" : @"poutineries"},
                          @{@"key" : @"Russian", @"code" : @"russian"},
                          @{@"key" : @"Salad", @"code" : @"salad"},
                          @{@"key" : @"Sandwiches", @"code" : @"sandwiches"},
                          @{@"key" : @"Scandinavian", @"code" : @"scandinavian"},
                          @{@"key" : @"Scottish", @"code" : @"scottish"},
                          @{@"key" : @"Seafood", @"code" : @"seafood"},
                          @{@"key" : @"Singaporean", @"code" : @"singaporean"},
                          @{@"key" : @"Slovakian", @"code" : @"slovakian"},
                          @{@"key" : @"Soul Food", @"code" : @"soulfood"},
                          @{@"key" : @"Soup", @"code" : @"soup"},
                          @{@"key" : @"Southern", @"code" : @"southern"},
                          @{@"key" : @"Spanish", @"code" : @"spanish"},
                          @{@"key" : @"Sri Lankan", @"code" : @"srilankan"},
                          @{@"key" : @"Steakhouses", @"code" : @"steak"},
                          @{@"key" : @"Sushi Bars", @"code" : @"sushi"},
                          @{@"key" : @"Taiwanese", @"code" : @"taiwanese"},
                          @{@"key" : @"Tapas Bars", @"code" : @"tapas"},
                          @{@"key" : @"Tapas/Small Plates", @"code" : @"tapasmallplates"},
                          @{@"key" : @"Tex-Mex", @"code" : @"tex-mex"},
                          @{@"key" : @"Thai", @"code" : @"thai"},
                          @{@"key" : @"Turkish", @"code" : @"turkish"},
                          @{@"key" : @"Ukrainian", @"code" : @"ukrainian"},
                          @{@"key" : @"Uzbek", @"code" : @"uzbek"},
                          @{@"key" : @"Vegan", @"code" : @"vegan"},
                          @{@"key" : @"Vegetarian", @"code" : @"vegetarian"},
                          @{@"key" : @"Vietnamese", @"code" : @"vietnamese"}
                          ];
    }
    return self;
}


- (NSDictionary *)setParams {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
   
    NSUInteger distanceIndex = [self.setDistance unsignedIntegerValue];
    if (distanceIndex != 0) {
        filters[@"radius_filter"] = self.distances[distanceIndex][@"value"];
    }
    
    NSUInteger sortModeIndex = [self.setSortBy unsignedIntegerValue];
    filters[@"sort"] = self.sortBy[sortModeIndex][@"value"];
    
    if (self.setOfferDeals) {
        filters[@"deals_filter"] = @"1";
    }
    
    if (self.setCategories.count > 0) {
        NSMutableArray *keys = [NSMutableArray array];
        for (NSDictionary *category in self.setCategories) {
            [keys addObject:category[@"code"]];
        }
        NSString *categoryFilter = [keys componentsJoinedByString:@","];
        filters[@"category_filter"] = categoryFilter;
        
    }
    
    return filters;
}




- (id)copyWithZone:(NSZone *)zone {
    Filters *copy = [[Filters allocWithZone:zone] init];
    copy.searchTerm = self.searchTerm;
    copy.setDistance = self.setDistance;
    copy.setSortBy = self.setSortBy;
    copy.setOfferDeals = self.setOfferDeals;
    copy.category = [self.category mutableCopy];
    return copy;
}



@end