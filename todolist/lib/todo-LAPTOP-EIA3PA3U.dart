class Todo {
  int? id;
  String nama;
  String deskripsi;
  bool done;

  Todo(this.nama, this.deskripsi, {this.done = false, this.id});

  static List<Todo> dummyData = [
    Todo("Latihan Menggambar", "Latihan Perlombaan Menggambar"),
    Todo("Makan Malam", "Makan Malam Bersama teman", done: true),
    Todo("Bernyanyi bersama", "Nyanyi bersama teman-teman"),
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'done': done ? 1 : 0, // Mengubah boolean menjadi integer
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      map['nama'] as String,
      map['deskripsi'] as String,
      done: map['done'] == 1, // Mengubah integer menjadi boolean
      id: map['id'],
    );
  }
}
