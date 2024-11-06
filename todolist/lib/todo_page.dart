import 'package:flutter/material.dart';
import 'package:todolist/database_helper.dart';
import 'package:todolist/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
  });

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  TextEditingController _namaCtrl = TextEditingController();
  TextEditingController _deskripsiCtrl = TextEditingController();

  List<Todo> todoList = [];

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
    });
  }

  void addItem() async {
    // todoList.add(Todo(_namaCtrl.text, _deskripsiCtrl.text));
    await dbHelper.addTodo(Todo(_namaCtrl.text, _deskripsiCtrl.text));
    refreshList();

    _namaCtrl.text = '';
    _deskripsiCtrl.text = '';
  }

  void updateItem(int index, bool done) async {
    todoList[index].done = done;
    await dbHelper.updateTodo(todoList[index]);
    refreshList();
  }

  void deleteItem(int id) async {
    // todoList.removeAt(index);
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
                  child: const Text("Tutup")),
              ElevatedButton(
                  onPressed: () {
                    addItem();
                    Navigator.pop(context);
                  },
                  child: const Text("Tambah")),
            ],
            content: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _namaCtrl,
                    decoration: InputDecoration(hintText: 'Nama Todo'),
                  ),
                  TextField(
                    controller: _deskripsiCtrl,
                    decoration:
                        InputDecoration(hintText: 'Deskripsi Pekerjaan'),
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi To Do List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tampilForm();
        },
        child: const Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: todoList[index].done
                          ? IconButton(
                              icon: const Icon(Icons.check_circle),
                              onPressed: () {
                                updateItem(index, !todoList[index].done);
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.radio_button_unchecked),
                              onPressed: () {
                                updateItem(index, !todoList[index].done);
                              },
                            ),
                      title: Text(todoList[index].nama),
                      subtitle: Text(todoList[index].deskripsi),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteItem(todoList[index].id ?? 0);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
