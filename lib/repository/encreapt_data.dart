import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart' as pointy_castle;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';


Uint8List _processInBlocks(
  pointy_castle.AsymmetricBlockCipher engine,
  Uint8List input,
) {
  final numBlocks = input.length ~/ engine.inputBlockSize +
      ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < input.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
        ? engine.inputBlockSize
        : input.length - inputOffset;

    outputOffset += engine.processBlock(
        input, inputOffset, chunkSize, output, outputOffset);

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}

Uint8List rsaEncrypt(RSAPublicKey publicKey, Uint8List dataToEncrypt) {
  final encryptor = pointy_castle.OAEPEncoding.withSHA256(pointy_castle.RSAEngine())
    ..init(
      true,
      pointy_castle.PublicKeyParameter<RSAPublicKey>(
        publicKey,
      ),
    );

  return _processInBlocks(encryptor, dataToEncrypt);
}

final key = encrypt.Key.fromSecureRandom(32);
final iv = encrypt.IV.fromSecureRandom(16);



/// encrypt data as AES format.
final encryptAES = encrypt.Encrypter(
  encrypt.AES(
    key,
    mode: encrypt.AESMode.cbc,
  ),
);

encryptData({required String value}) {
  return encryptAES.encrypt(value, iv: iv).base16;
}

// splitStr(String str) {
//   var begin = '-----BEGIN PUBLIC KEY-----\n';
//   var end = '\n-----END PUBLIC KEY-----';
//   int splitCount = str.length ~/ 64;
//   List<String> strList=[];
//
//   for (int i=0; i<splitCount; i++) {
//     strList.add(str.substring(64*i, 64*(i+1)));
//   }
//   if (str.length%64 != 0) {
//     strList.add(str.substring(64*splitCount));
//   }
//
//   return begin + strList.join('\n') + end;
// }