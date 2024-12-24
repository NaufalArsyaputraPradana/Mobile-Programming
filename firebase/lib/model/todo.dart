class Todo {
  final String id;
  final String nama;
  final String deskripsi;
  final bool done;

  Todo({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.done,
  });

  static List<Todo> dummyData = [];

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
      id: map['id'] as String,
      nama: map['nama'] as String,
      deskripsi: map['deskripsi'] as String,
      done: map['done'] == 1, // Mengubah integer menjadi boolean
    );
  }
}