//
//  SAN_Cell2.m
//  UseMe
//
//  Created by Santhosh Kumar on 8/30/13.
//  Copyright (c) 2013 Santhosh Kumar. All rights reserved.
//

#import "SAN_Cell2.h"

@implementation SAN_Cell2

- (id)init:(NSUInteger)count
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SAN_Cell2" owner:self options:nil] objectAtIndex:0];
    NSUInteger r,c;
    self.imageArray = [[NSMutableArray alloc] init];
    for(NSUInteger i=0;i<count;i++){
        r=i/4;
        c =i%4;
        
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(25+c*(10+60) ,20 + (r+1)*10 + r*60, 60, 60)];
        v.contentMode = UIViewContentModeScaleAspectFit;
        v.backgroundColor = [UIColor blackColor];
        [self addSubview:v];
        [self.imageArray addObject:v];
    }
    
    if(count >0){
        CGRect f = self.frame;
        f.size.height = 20 + (60 + 10)*((count-1)/4 + 1) +10;
        self.frame = f;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
