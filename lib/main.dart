import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:votes_app/pages/home.dart';
import 'package:votes_app/pages/status.dart';
import 'package:votes_app/services/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((_) => SocketService()),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'status': ((_) => const StatusPage())
        },
      ),
    );
  }
}
