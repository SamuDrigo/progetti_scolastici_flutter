import 'package:flutter/material.dart';
import 'package:esercizio_2_1/todo.dart';
import "package:reactive_forms/reactive_forms.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ).primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const TodoListScreen(title: 'ToDo App'),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key, required this.title});
  final String title;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _list = <Todo>[];

  void _addTask() async {
    final result = await showDialog<Todo>(
      context: context,
      builder: (context) {
        return const AddTaskScreen();
      },
    );

    if (result == null) return;

    setState(() {
      _list.add(result);
    });
  }

  bool showDone = false;
  List<Todo> get filteredList =>
      showDone ? _list.where((task) => !task.isDone).toList() : _list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        actions: [
          IconButton(
            icon: Icon(showDone ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() {
                showDone = !showDone;
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: filteredList
            .map(
              (todo) => CheckboxListTile(
                value: todo.isDone,
                onChanged: (value) {
                  setState(() {
                    todo.isDone = value!;
                  });
                },
                title: Text(
                  todo.title,
                  style: todo.isDone
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                subtitle: Text(todo.description),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final form = FormGroup({
    'title': FormControl<String>(
      validators: [Validators.required, Validators.minLength(3)],
    ),
    'description': FormControl<String>(
      validators: [Validators.required, Validators.minLength(20)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'title',
                decoration: const InputDecoration(hintText: 'Insert title...'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Titolo obbligatorio',
                  ValidationMessage.minLength: (error) =>
                      'Il titolo deve avere almeno 3 caratteri',
                },
              ),
              const SizedBox(height: 12),
              ReactiveTextField<String>(
                formControlName: 'description',
                decoration: const InputDecoration(
                  hintText: 'Add description...',
                ),
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'La descrizione è obbligatoria',
                  ValidationMessage.minLength: (error) =>
                      'La descrizione deve essere di almeno 20 caratteri',
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (!form.valid) {
                    form.markAllAsTouched();
                    return;
                  }

                  final todo = Todo(
                    title: form.control('title').value,
                    description: form.control('description').value,
                    createdAt: DateTime.now(),
                  );

                  Navigator.pop(context, todo);
                },
                child: const Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
