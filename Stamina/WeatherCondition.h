//
//  WeatherCondition.h
//  Stamina
//
//  Created by João Lucas Sisanoski on 31/10/14.
//  Copyright (c) 2014 Danilo Augusto Mative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherCondition : NSObject
@property float tempMax;
@property float tempMin;
@property float humidade;
@property float tempAtual;
@property NSString *descricao;
@end
