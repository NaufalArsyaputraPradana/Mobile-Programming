import 'package:flutter/material.dart';
import 'package:firebase/model/database_helper.dart';
import 'package:firebase/model/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _namaCtrl = TextEditingController();
  final TextEditingController _deskripsiCtrl = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Todo> todoList = [];
  List<Todo> filteredTodoList = [];
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() async {
    final todos = await dbHelper.getAllTodos();
    setState(() {
      todoList = todos;
      filteredTodoList = todos; // Initialize filtered list
    });
  }

  void addItem() async {
    if (_namaCtrl.text.isNotEmpty && _deskripsiCtrl.text.isNotEmpty) {
      await dbHelper.addTodo(Todo(
        _namaCtrl.text,
        _deskripsiCtrl.text,
      ));
      _namaCtrl.clear();
      _deskripsiCtrl.clear();
      Navigator.pop(context); // Close dialog after adding
      refreshList();
    } else {
      _showErrorDialog('Nama dan deskripsi tidak boleh kosong.');
    }
  }

  void updateItem(int index, bool done) async {
    todoList[index].done = done;
    await dbHelper.updateTodo(todoList[index]);
    refreshList();
  }

  void deleteItem(int id) async {
    await dbHelper.deleteTodo(id);
    refreshList();
  }

  void tampilForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        title: const Text("Tambah Todo"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Tutup"),
          ),
          ElevatedButton(
            onPressed: addItem,
            child: const Text("Tambah"),
          ),
        ],
        content: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextField(
                controller: _namaCtrl,
                decoration: const InputDecoration(hintText: 'Nama Todo'),
              ),
              TextField(
                controller: _deskripsiCtrl,
                decoration: const InputDecoration(hintText: 'Deskripsi Pekerjaan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kesalahan'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _filterTodos(String query) {
    final filtered = todoList.where((todo) {
      return todo.nama.toLowerCase().contains(query.toLowerCase()) ||
             todo.deskripsi.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredTodoList = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi To Do List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tampilForm,
        child: const Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterTodos,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: IconButton(
                    icon: filteredTodoList[index].done
                        ? const Icon(Icons.check_circle)
                        : const Icon(Icons.radio_button_unchecked),
                    onPressed: () {
                      updateItem(todoList.indexOf(filteredTodoList[index]), !filteredTodoList[index].done);
                    },
                  ),
                  title: Text(filteredTodoList[index].nama),
                  subtitle: Text(filteredTodoList[index].deskripsi),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteItem(filteredTodoList[index].id ?? 0);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}