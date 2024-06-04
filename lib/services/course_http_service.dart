import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/models/lesson_model.dart';
import 'package:settings_page/models/quiz_model.dart';

class CourseHttpService {
  Future<List<Course>> getData() async {
    final Uri url = Uri.parse(
      'https://lesson46-c2288-default-rtdb.firebaseio.com/.json',
    );

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      List<Course> loadedCourses = [];
      data.forEach(
        (String key, dynamic value) {
          value['id'] = key;
          loadedCourses.add(Course.fromJson(value));
        },
      );
      print(loadedCourses.length);
      return loadedCourses;
    }
    throw Exception('Error: CourseHttpService().getData()');
  }

  Future<Course> addCourse({
    required String courseTitle,
    required String courseDescription,
    required String courseImageUrl,
    required List<Lesson> courseLessons,
    required num coursePrice,
  }) async {
    Map<String, dynamic> courseData = {
      'course-title': courseTitle,
      'course-description': courseDescription,
      'course-image': courseImageUrl,
      'course-lessons': courseLessons.map((lesson) => lesson.toJson()).toList(),
      'course-price': coursePrice,
    };
    final Uri url = Uri.parse(
      'https://lesson46-c2288-default-rtdb.firebaseio.com/.json',
    );
    final http.Response response = await http.post(
      url,
      body: jsonEncode(courseData),
    );
    final data = jsonDecode(response.body);
    courseData['id'] = data['name'];
    return Course.fromJson(courseData);
  }

  Future<void> deleteCourse({required String id}) async {
    final Uri url = Uri.parse(
      'https://lesson46-c2288-default-rtdb.firebaseio.com/$id.json',
    );
    await http.delete(url);
  }
}

// void main() async {
//   var s = CourseHttpService();
//   // await s.getData();
//   s.addCourse(
//     courseTitle: 'Flutter',
//     courseDescription:
//         'Flutter courses can teach you how to build mobile applications for both Android and iOS devices using the Flutter framework. They typically cover the Dart programming language, which is what Flutter uses, as well as the widget-based UI structure that Flutter is known for.',
//     courseImageUrl:
//         'https://www.classcentral.com/report/wp-content/uploads/2022/09/BCG-Flutter-Featured-Banner.png',
//     courseLessons: [
//       Lesson(
//         lessonId: 1,
//         courseId: 1,
//         lessonTitle: 'Flutter lesson 1',
//         lessonDescription: 'Entering',
//         videoUrl: 'videoUrl',
//         lessonQuiz: [
//           Quiz(
//             qCorrectAnswer: 1,
//             qId: 1,
//             qOptions: ['yes', 'no'],
//             qQuestion: 'Is apple sweet?',
//           ),
//         ],
//       ),
//     ],
//     coursePrice: 780,
//   );
// }
