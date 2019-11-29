//
//  DesHelper.m
//  TouchDoc
//
//  Created by Edward on 2019/7/15.
//  Copyright © 2019 Wisefly. All rights reserved.
//

#import "DesHelper.h"
#import "GTMBase64.h"
@interface DesHelper()
@end
static DesHelper *instance = nil;
@implementation DesHelper

+(instancetype)GetInstance{
    if(!instance){
        instance = [[DesHelper alloc]init];
    }
    return instance;
}
+(instancetype)alloc{
    if(instance){
        NSException *ecs = [NSException exceptionWithName:@"error" reason:@"can not creat a danli" userInfo:nil];
        [ecs raise];
    }
    return [super alloc];
}
#pragma mark MD5加解秘钥

#pragma mark 解密
-(NSString *)DecryptUseDES:(NSString *)message :(NSString *)key
{
    @try {
        //MD5
        Byte _Key[8];
        Byte _Iv[8];
        const char *cStr = [key UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
        for(int i=0;i<8;i++){
            _Key[i] = result[i];
            _Iv[i] = result[i+8];
        }
        //正式解
        NSString *plaintext = nil;
        NSData *cipherdata = [GTMBase64 decodeString:message];
        //    unsigned char buffer[102400];
        NSUInteger dataLength = [cipherdata length];
        size_t bufferSize = dataLength + kCCBlockSizeDES;
        void *buffer = malloc(bufferSize);
        memset(buffer, 0, sizeof(char));
        size_t numBytesDecrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                              kCCOptionPKCS7Padding,
                                              _Key, kCCKeySizeDES,
                                              _Iv,
                                              [cipherdata bytes], [cipherdata length],
                                              buffer, bufferSize,
                                              &numBytesDecrypted);
        if(cryptStatus == kCCSuccess) {
            NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
            plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        }
        free(buffer);
        return plaintext;
    } @catch (NSException *exception) {
        NSString *errstr = [NSString stringWithFormat:@"DesHelper.decryptUseDES:%@",exception.reason];
        NSLog(@"%@",errstr);
        return errstr;
    }
}
#pragma mark 加密
-(NSString *)EncryptUseDES:(NSString *)message :(NSString *)key
{
    @try {
        //加密
        //MD5
        Byte _Key[8];
        Byte _Iv[8];
        const char *cStr = [key UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
        for(int i=0;i<8;i++){
            _Key[i] = result[i];
            _Iv[i] = result[i+8];
        }
        NSString *ciphertext = nil;
        NSData *textData = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSUInteger dataLength = [textData length];
        size_t bufferSize = dataLength + kCCBlockSizeDES;
        void *buffer = malloc(bufferSize);
        
        
        memset(buffer, 0, sizeof(char));
        size_t numBytesEncrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                              kCCOptionPKCS7Padding,
                                              _Key, kCCKeySizeDES,
                                              _Iv,
                                              [textData bytes], dataLength,
                                              buffer, bufferSize,
                                              &numBytesEncrypted);
        if (cryptStatus == kCCSuccess) {
            NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
            ciphertext = [self SetPar:[GTMBase64 stringByEncodingData:data]];
        }
        free(buffer);
        return ciphertext;
    } @catch (NSException *exception) {
        NSString *errstr = [NSString stringWithFormat:@"DesHelper.encryptUseDES:%@",exception.reason];
        NSLog(@"%@",errstr);
        return errstr;
    }
}
-(NSString *)SetPar:(NSString *)para{
//    NSLog(@"%@",para);
    if([para containsString:@"%"]){
        para = [para stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    }
    if([para containsString:@"+"]){
        para = [para stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    }
    if([para containsString:@" "]){
        para = [para stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    if([para containsString:@"/"]){
        para = [para stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    }
    if([para containsString:@"?"]){
        para = [para stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    }
    if([para containsString:@"#"]){
        para = [para stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    }
    if([para containsString:@"&"]){
        para = [para stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    }
    if([para containsString:@"="]){
        para = [para stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    }
    NSLog(@"%@",para);
    return para;
}


@end
