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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
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
          print(candidate.name);
        },
      );
}
