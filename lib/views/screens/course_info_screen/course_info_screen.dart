import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:settings_page/views/screens/quiz_screen/quiz_screen.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class CourseInfoScreen extends StatefulWidget {
  final Course course;

  const CourseInfoScreen({super.key, required this.course});

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  String toLaunch = 'https://youtu.be/cvh0nX08nRw?si=OGggf9tYYrGuBb5v';
  Future<void>? _launched;
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  Future<void> _launchInCustomTab(String url) async {
    if (!await launcher.launchUrl(
      url,
      const LaunchOptions(mode: PreferredLaunchMode.inAppBrowserView),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.courseTitle),
        centerTitle: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Image.network(
            widget.course.courseImageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Course description: ${widget.course.courseDescription}'),
                Text('Course price: \$${widget.course.coursePrice}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Courses',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: widget.course.courseLessons.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => setState(() {
                _launched = _launchInCustomTab(toLaunch);
              }),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.course.courseLessons[index].lessonTitle),
                        Text(widget
                            .course.courseLessons[index].lessonDescription),
                      ],
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (BuildContext context) => QuizScreen(
                              lessonTitle: widget.course.courseLessons[index].lessonTitle,
                              quiz:
                                  widget.course.courseLessons[index].lessonQuiz,
                            ),
                          ),
                        );
                      },
                      child: Text('Go to Quiz page'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//

//ElevatedButton(
//
//                 child: const Text('Launch in Android Custom Tab'),
//               ),
