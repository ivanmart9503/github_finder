import 'dart:io';

import 'package:injectable/injectable.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      await InternetAddress.lookup('www.google.com');
      return true;
    } on SocketException {
      return false;
    }
  }
}
