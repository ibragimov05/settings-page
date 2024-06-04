// class Quiz {
//   final int quizId;
//   String quizQuestion;
//   List<String> quizOptions;
//   int quizCorrectAnswer;
//
//   Quiz({
//     required this.quizId,
//     required this.quizQuestion,
//     required this.quizOptions,
//     required this.quizCorrectAnswer,
//   });
//
//   factory Quiz.fromJson(Map<String, dynamic> json) {
//     return Quiz(
//       quizId: json['q-id'],
//       quizQuestion: json['q-question'],
//       quizOptions: json['q-options'],
//       quizCorrectAnswer: json['q-correctAnswer'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'q-id': quizId,
//       'q-question': quizQuestion,
//       'q-options': quizOptions,
//       'q-correctAnswer': quizCorrectAnswer,
//     };
//   }
// }

class Quiz {
  int qCorrectAnswer;
  int qId;
  List<String> qOptions;
  String qQuestion;

  Quiz({
    required this.qCorrectAnswer,
    required this.qId,
    required this.qOptions,
    required this.qQuestion,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      qCorrectAnswer: json['q-correctAnswer'],
      qId: json['q-id'],
      qOptions: List<String>.from(json['q-options']),
      qQuestion: json['q-question'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q-correctAnswer': qCorrectAnswer,
      'q-id': qId,
      'q-options': qOptions,
      'q-question': qQuestion,
    };
  }
}