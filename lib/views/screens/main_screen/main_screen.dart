import 'package:flutter/material.dart';
import 'package:settings_page/models/course_model.dart';
import 'package:settings_page/viewmodels/course_view_model.dart';
import 'package:settings_page/views/screens/notes_screen.dart';
import 'package:settings_page/views/screens/todo_screen/todo_screen.dart';
import 'package:settings_page/views/widgets/custom_inkwell_button.dart';
import 'package:settings_page/views/widgets/custom_list_view_builder_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CourseViewModel _courseViewModel = CourseViewModel();
  bool _isViewStylePressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomInkwellButton(
                nextPage: const TodoScreen(),
                buttonText: AppLocalizations.of(context)!.todos,
              ),
               CustomInkwellButton(
                nextPage: NoteScreen(),
                buttonText: AppLocalizations.of(context)!.notes,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(
                  () => _isViewStylePressed = !_isViewStylePressed,
                ),
                child: Text(AppLocalizations.of(context)!.changeViewStyle),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: _courseViewModel.courseList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(child: Text('error: ${snapshot.error}'));
                } else {
                  List<Course> courseList = snapshot.data;
                  return _isViewStylePressed
                      ? GridView.builder(
                          itemCount: courseList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.3,
                          ),
                          itemBuilder: (context, index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        )
                      : ListView.builder(
                          itemCount: courseList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CustomListViewBuilderContainer(
                            isViewStylePressed: _isViewStylePressed,
                            course: courseList[index],
                            isDelete: false,
                          ),
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
