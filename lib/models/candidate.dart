class Candidate {
  String id;
  String name;
  int votes;

  Candidate({required this.id, required this.name, required this.votes});

  factory Candidate.fromMap(Map<String, dynamic> obj) =>
      Candidate(id: obj['id'], name: obj['name'], votes: obj['votes']);

  String getInitial() {
    return name.substring(0, 1);
  }
}
