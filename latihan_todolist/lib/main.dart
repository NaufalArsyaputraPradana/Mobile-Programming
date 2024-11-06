import 'package:flutter/material.dart';
import 'catatan.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController judulCtrl = TextEditingController();
  TextEditingController isiCtrl = TextEditingController();
  List<Catatan> listCatatan = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Catatan Pagi"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.grey[200],
          child: Column(
            children: [
              TextField(
                controller: judulCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Judul catatan",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: isiCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Isi catatan",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        judulCtrl.clear();
                        isiCtrl.clear();
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text("Clear"),
                      style: ElevatedButton.styleFrom(iconColor: Colors.red),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("Submit button pressed");
                        setState(() {
                          listCatatan.add(Catatan(
                            judul: judulCtrl.text,
                            isi: isiCtrl.text,
                          ));
                          judulCtrl.clear();
                          isiCtrl.clear();
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Submit"),
                      style: ElevatedButton.styleFrom(iconColor: Colors.green),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: listCatatan.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: InkWell(
                        onTap: () {
                          print(listCatatan[index].judul);
                          print(listCatatan[index].isi);
                          print(listCatatan[index].tglInput);
                        },
                        child: ListTile(
                          leading: const Icon(Icons.event_note_rounded),
                          title: Text(
                            listCatatan[index].judul,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(listCatatan[index].isi),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
