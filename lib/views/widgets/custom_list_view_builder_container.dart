import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/views/screens/course_info_screen/course_info_screen.dart';

class CustomListViewBuilderContainer extends StatelessWidget {
  final bool isViewStylePressed;
  final Course course;
  final bool isDelete;
  final Function()? onDeletePressed;

  CustomListViewBuilderContainer({
    super.key,
    required this.course,
    required this.isViewStylePressed,
    required this.isDelete,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => CourseInfoScreen(course: course),
          ),
        );
      },
      child: Container(
        margin: isViewStylePressed ? null : const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
        child: isViewStylePressed
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course name: ${course.courseTitle}'),
                  Text('Description:  ${course.courseDescription}'),
                  Text('Price: ${course.coursePrice}'),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Course name: ${course.courseTitle}'),
                          Text('Description:  ${course.courseDescription.split(' ')[0]}'),
                        ],
                      ),
                      Text('Price: ${course.coursePrice}'),
                    ],
                  ),
                  if (isDelete)
                    TextButton(onPressed: onDeletePressed, child: const Text('Delete course')),
                ],
              ),
      ),
    );
  }
}
