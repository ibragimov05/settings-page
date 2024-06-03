import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:settings_page/models/todo_model.dart';
import 'package:settings_page/utils/app_constants.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';
import 'package:settings_page/views/screens/profile_screen.dart';
import 'package:settings_page/views/screens/results_screen.dart';
import 'package:settings_page/views/widgets/custom_drawer.dart';
import 'package:settings_page/views/widgets/manage_todo_dialog.dart';
import 'package:settings_page/views/widgets/todos_widget.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  void onAddPressed() async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => const ManageTodoDialog(
        isEdit: false,
      ),
    );
    if (data.isNotEmpty) {
      _todoViewModel.addTodo(
        todoTitle: data['todoTitle'],
        todoDescription: data['todoDescription'],
      );
      setState(() {});
    }
  }

  void onTogglePressed(List<Todo> todos, int index) {
    _todoViewModel.toggleTodo(
      todoId: todos[index].todoId,
      todoStatus: !todos[index].isDone,
    );
    setState(() {});
  }

  void onEditPressed(Todo todo) async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => ManageTodoDialog(
        todo: todo,
        isEdit: true,
      ),
    );
    if (data.isNotEmpty) {
      _todoViewModel.editTodo(
        todoId: todo.todoId,
        newTodoTitle: data['todoTitle'],
        newTodoDescription: data['todoDescription'],
      );
      setState(() {});
    }
  }

  void onDeletePressed({required String todoId}) {
    _todoViewModel.deleteProduct(todoId: todoId);
    setState(() {});
  }

  int _currentIndex = 0;
  final List<Widget> _pages = const <Widget>[
    ResultsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            AppConstants.imageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Make Scaffold background transparent
        appBar: AppBar(
          title: Text(
            "Main page",
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: AppConstants.textSize,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text(AppConstants.language),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: onAddPressed,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: _currentIndex == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder(
                  future: _todoViewModel.todoList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('Add notes'),
                      );
                    }
                    final List<Todo> todos = snapshot.data;
                    return todos.isEmpty
                        ? const Center(
                            child: Text('Add notes'),
                          )
                        : ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              return TodosWidget(
                                onTogglePressed: () {
                                  onTogglePressed(todos, index);
                                },
                                onDeletePressed: () {
                                  onDeletePressed(todoId: todos[index].todoId);
                                },
                                onEditPressed: () {
                                  onEditPressed(todos[index]);
                                },
                                todos: todos,
                                index: index,
                              );
                            },
                          );
                  },
                ),
              )
            : _pages[_currentIndex - 1],
        drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
          onBackgroundChanged: widget.onBackgroundChanged,
          onLanguageChanged: widget.onLanguageChanged,
          onColorChanged: widget.onColorChanged,
          onTextChanged: widget.onTextChanged,
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.amber,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Main"),
              selectedColor: Colors.purple,
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.auto_graph_outlined),
              title: Text("Results"),
              selectedColor: Colors.pink,
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
