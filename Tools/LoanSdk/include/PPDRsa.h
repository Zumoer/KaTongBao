//
// Created by sqiu on 15/3/11.
// Copyright (c) 2015 QS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RSA_PKCS1_PADDING	1
#define RSA_SSLV23_PADDING	2
#define RSA_NO_PADDING		3
#define RSA_PKCS1_OAEP_PADDING	4
#define RSA_X931_PADDING	5
/* EVP_PKEY_ only */
#define RSA_PKCS1_PSS_PADDING	6

#define RSA_PKCS1_PADDING_SIZE	11

@interface PPDRsa : NSObject

@property (nonatomic, assign) BOOL isHasPrivateRsa;

@property(nonatomic) int padding;

- (id)initWithPadding:(int)padding;

- (void)addPublicKeyValue:(NSString *)publicKey;

- (void)addPrivateKeyValue:(NSString *)privateKey;

- (NSData *)encryptDataWithPublicKey:(NSData *)data;

- (NSData *)encryptDataWithPrivateKey:(NSData *)data;

- (NSData *)decryptDataWithPublicKey:(NSData *)data;

- (NSData *)decryptDataWithPrivateKey:(NSData *)data;

- (NSData *)sign:(NSData *)data;

- (BOOL)verify:(NSData *)signature message:(NSData *)data;
@end