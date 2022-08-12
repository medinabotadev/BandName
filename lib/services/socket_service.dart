import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, fffline, connecting }

class SocketService with ChangeNotifier {
  final ServerStatus _serverStatus = ServerStatus.connecting;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    io.Socket socket = io.io('http://localhost:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.onConnect((_) {
      debugPrint('connect');
    });
    socket.onDisconnect((_) => debugPrint('disconnect'));
  }
}
