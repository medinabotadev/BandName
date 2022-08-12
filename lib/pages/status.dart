import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votes_app/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    // socketService.socket.emit(event);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Server status: ${socketService.serverStatus}'),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        socketService.socket.emit('emit-message', {'nombre': 'Flutter', 'mensaje': 'Hola desde flutter'});
      },
      child: const Icon(Icons.message),
    ),
    );
  }
}
