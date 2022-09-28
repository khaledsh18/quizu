class Leader{
  final String name;
  final int score;

  Leader({required this.name, required this.score});

  static Leader fromJson(json)=> Leader(
    name: json['name'],
    score: json ['score']
  );
}