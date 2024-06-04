import 'package:flutter/material.dart';
import 'package:settings_page/models/quiz_model.dart';
import 'package:settings_page/views/widgets/custom_quiz_maker.dart';

class QuizScreen extends StatefulWidget {
  final String lessonTitle;
  final List<Quiz> quiz;

  const QuizScreen({super.key, required this.lessonTitle, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<String?> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String?>.filled(widget.quiz.length, null);
  }

  void updateSelectedOption({required int index, required String? option}) {
    selectedOptions[index] = option;
    setState(() {});
  }

  void checkAnswers() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.quiz.length; i++) {
      if (selectedOptions[i] ==
          widget.quiz[i].qOptions[widget.quiz[i].qCorrectAnswer]) {
        correctAnswers++;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Result'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You got $correctAnswers out of ${widget.quiz.length}'),
            if (correctAnswers == widget.quiz.length)
              Text('Congratulations, you are genius'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lessonTitle),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: ListView.builder(
                itemCount: widget.quiz.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    for (Quiz each in widget.quiz)
                      CustomQuizMaker(
                        question: each.qQuestion,
                        answer: each.qCorrectAnswer,
                        options: each.qOptions,
                        onOptionSelected: (String? value) =>
                            updateSelectedOption(
                          index: index,
                          option: value,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: checkAnswers,
            child: Text('Check answer'),
          ),
        ],
      ),
    );
  }
}
