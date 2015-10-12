//
//  ViewController.m
//  加密解密
//
//  Created by 杜立广 on 15/10/10.
//  Copyright © 2015年 杜立广. All rights reserved.
//

#import "ViewController.h"
#import "NSData+EncryptAndDecrypt.h"
@interface ViewController (){
    NSData *base64DecodeData;
    NSString *base64Str;
    
}
- (IBAction)jiami:(id)sender;
- (IBAction)jiemi:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mingwen;

@property (weak, nonatomic) IBOutlet UILabel *jiamihou;
@property (weak, nonatomic) IBOutlet UILabel *jiemihou;
@property (weak, nonatomic) IBOutlet UITextField *Key;
@property (weak, nonatomic) IBOutlet UITextField *keyone;



@end

@implementation ViewController


-(void)dismissKeyboard
{
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews)
    {
        if ([objInput isKindOfClass:[UITextField class]])
        {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder])
            {
                [theTextField resignFirstResponder];
            }
        }
    }
}
- (void)viewDidLoad
{         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)jiami:(id)sender {
    //明文
    NSString *plainText = self.mingwen.text;
    
    NSLog(@"明文是：%@", plainText);
    
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];

    //密钥
    NSString *da=self.keyone.text;
    NSData* keyData=[da dataUsingEncoding:NSUTF8StringEncoding];
    

    //加密
    NSData *cipherTextData = [plainTextData AES256EncryptWithKey:keyData];
    

    
    //加密后的数据转base64
    base64Str = [cipherTextData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSLog(@"加密后的数据nsdata转base64 = %@",base64Str);
    
    self.jiamihou.text=base64Str;
}

- (IBAction)jiemi:(id)sender {

    //base64转nsdata
    NSString *da=self.Key.text;
    NSData* keyData=[da dataUsingEncoding:NSUTF8StringEncoding];
    base64DecodeData = [[NSData alloc] initWithBase64EncodedString:base64Str options:0];
    
    
    
    //解密
    NSData *decryptedData = [base64DecodeData AES256DecryptWithKey:keyData];
    
    
    NSString *decryptStr = [[NSString alloc]initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"解密后：%@", decryptStr);
     self.jiemihou.text=decryptStr;
    
  
    
    
    
    
}



@end
