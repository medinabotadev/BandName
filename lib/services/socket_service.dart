import 'dart:io';

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = io.io(Platform.isAndroid ? 'http://10.0.2.2:3000/' : 'http://localhost:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.onConnecting((_) {
      debugPrint('connecting');
      _serverStatus = ServerStatus.connecting;
      notifyListeners();
    });
    _socket.onConnect((_) {
      debugPrint('connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      debugPrint('disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
    // socket.on('new-message', (payload) {
    //   debugPrint('new-message:');
    //   debugPrint('name:' + payload['name']);
    //   debugPrint('message:' + payload['message']);
    //   debugPrint('message2:' +
    //       (payload.containsKey('mensaje2')
    //           ? payload['message2']
    //           : 'no hay segundo mensaje'));
    // });
  }
}
