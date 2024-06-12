import 'package:flutter/material.dart';
import 'package:settings_page/models/todo_model.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';
import 'package:settings_page/views/widgets/manage_todo_dialog.dart';
import 'package:settings_page/views/widgets/todos_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoViewModel.todoList;
    setState(() {
      _todos = todos;
    });
  }

  void onAddPressed() async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => const ManageTodoDialog(
        isEdit: false,
      ),
    );
    if (data.isNotEmpty) {
      await _todoViewModel.addTodo(
        todoTitle: data['todoTitle'],
        todoDescription: data['todoDescription'],
      );
      _loadTodos(); // Reload the todos list
    }
  }

  void onTogglePressed(int index) async {
    await _todoViewModel.toggleTodo(
      todoId: _todos[index].todoId,
      todoStatus: !_todos[index].isDone,
    );
    _loadTodos(); // Reload the todos list
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
      await _todoViewModel.editTodo(
        todoId: todo.todoId,
        newTodoTitle: data['todoTitle'],
        newTodoDescription: data['todoDescription'],
      );
      _loadTodos(); // Reload the todos list
    }
  }

  void onDeletePressed({required String todoId}) async {
    await _todoViewModel.deleteProduct(todoId: todoId);
    _loadTodos(); // Reload the todos list
  }

  bool isSorted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Todo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _todos.isEmpty
            ? const Center(
                child: Text('Add notes'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return TodosWidget(
                          onTogglePressed: () {
                            onTogglePressed(index);
                          },
                          onDeletePressed: () {
                            onDeletePressed(todoId: _todos[index].todoId);
                          },
                          onEditPressed: () {
                            onEditPressed(_todos[index]);
                          },
                          todos: _todos,
                          index: index,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!isSorted) {
                        _todos.sort((a, b) =>
                            b.todoCreatedDate.compareTo(a.todoCreatedDate));
                      } else {
                        _todos.sort((a, b) =>
                            a.todoCreatedDate.compareTo(b.todoCreatedDate));
                      }
                      isSorted = !isSorted;
                      setState(() {});
                    },
                    child: const Text('Sort'),
                  ),
                ],
              ),
      ),
    );
  }
}
