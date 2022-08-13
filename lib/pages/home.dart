import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:votes_app/models/candidate.dart';
import 'package:votes_app/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Candidate> candidates = [];

  @override
  void initState() {
    final SocketService socketService = Provider.of(context, listen: false);
    socketService.socket.on('active-candidates', (payload) {
      candidates = (payload as List).map((candidate) {
        return Candidate.fromMap(candidate);
      }).toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    final SocketService socketService = Provider.of(context, listen: false);
    socketService.socket.off('active-candidates');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            margin: const EdgeInsets.only(right: 10.0),
            child: socketService.serverStatus == ServerStatus.online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue[300],
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red[300],
                  ),
          )
        ],
        title: const Text(
          'VotesApp',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return _CandidateTile(candidate: candidates[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: addNewCandidate,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNewCandidate() {
    final TextEditingController textController = TextEditingController();
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New candidate name'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () => addCandidateToList(textController.text),
                  elevation: 0,
                  color: Colors.blue,
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          });
      return;
    }

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('New candidate name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addCandidateToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void addCandidateToList(String name) {
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    if (name.length > 1) {
      socketService.socket.emit('add-candidate', Candidate(name: name).toMap());
    }

    Navigator.pop(context);
  }
}

class _CandidateTile extends StatelessWidget {
  Candidate candidate;
  _CandidateTile({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SocketService socketService =
        Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: ((direction) =>
          socketService.socket.emit('delete-candidate', candidate.toMap())),
      background: Container(
        padding: const EdgeInsets.only(left: 10.0),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete candidate',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(candidate.getInitial()),
        ),
        title: Text(candidate.name),
        trailing: Text(
          '${candidate.votes}',
          style: const TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        onTap: () {
          socketService.socket.emit('vote-candidate', candidate.toMap());
        },
      ),
    );
  }
}
