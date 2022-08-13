class Candidate {
  String? id;
  String name;
  int? votes;

  Candidate({this.id, required this.name, this.votes});

  factory Candidate.fromMap(Map<String, dynamic> obj) => Candidate(
      id:     obj.containsKey('id')     ? obj['id']     : '',
      name:   obj.containsKey('name')   ? obj['name']   : '',
      votes:  obj.containsKey('votes')  ? obj['votes']  : '');

  String getInitial() {
    return name.substring(0, 1);
  }

  Map<String, dynamic> toMap(){
    return {
      'id' :  id,
      'name' : name,
      'votes' :  votes
    };
  }
}
