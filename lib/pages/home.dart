import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:votes_app/models/candidate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Candidate> candidates = [
    Candidate(id: '1', name: 'Medina', votes: 14),
    Candidate(id: '2', name: 'Gonzalez', votes: 3),
    Candidate(id: '3', name: 'Robens', votes: 6),
    Candidate(id: '4', name: 'Mendoza', votes: 4),
    Candidate(id: '5', name: 'Trump', votes: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
    if (name.length > 1) {
      candidates.add(Candidate(id: null, name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}

class _CandidateTile extends StatelessWidget {
  Candidate candidate;
  _CandidateTile({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
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
          debugPrint(candidate.name);
        },
      );
}
