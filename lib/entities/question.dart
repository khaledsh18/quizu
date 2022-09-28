class Question{
  final String question;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;


  Question({required this.question, required this.answerA, required this.answerB, required this.answerC,
    required this.answerD, required this.correctAnswer});


  static Question fromJson(json)=> Question(
      question: json['Question'],
      answerA: json['a'],
      answerB: json['b'],
      answerC: json['c'],
      answerD: json['d'],
      correctAnswer: json['correct']);
}