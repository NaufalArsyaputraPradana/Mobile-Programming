import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Map<String, dynamic>> barangList = [
    {'nama': 'Laptop', 'harga': 25000000},
    {'nama': 'Mouse', 'harga': 1250000},
    {'nama': 'Monitor', 'harga': 1500000},
    {'nama': 'Keyboard', 'harga': 500000},
    {'nama': 'Printer', 'harga': 2200000},
  ];

  List<Map<String, dynamic>> strukList = [];
  List<TextEditingController> controllers = [];
  int totalBayar = 0;

  @override
  void initState() {
    super.initState();
    for (var item in barangList) {
      controllers.add(TextEditingController());
    }
  }

  void reset() {
    setState(() {
      strukList.clear();
      totalBayar = 0;
      for (var controller in controllers) {
        controller.clear();
      }
    });
  }

  void cetakStruk() {
    int total = 0;
    strukList.clear();
    for (int index = 0; index < barangList.length; index++) {
      int jumlah = int.tryParse(controllers[index].text) ?? 0;
      if (jumlah > 0) {
        int subtotal = barangList[index]['harga'] * jumlah;
        total += subtotal;
        strukList.add({
          'nama': barangList[index]['nama'],
          'jumlah': jumlah,
          'subtotal': subtotal,
        });
      }
    }
    setState(() {
      totalBayar = total;
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Toko Komputer"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[200],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: barangList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(barangList[index]['nama']),
                          subtitle:
                              Text('Harga: ${barangList[index]['harga']}'),
                          trailing: SizedBox(
                            width: 100,
                            child: TextField(
                              controller: controllers[index],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Jumlah",
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: reset,
                      child: const Text("Reset"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700]),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: cetakStruk,
                      child: const Text("Cetak Struk"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Total Bayar : \Rp${totalBayar}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: strukList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(strukList[index]['nama']),
                      subtitle: Text('Jumlah: ${strukList[index]['jumlah']}'),
                      trailing: Text(
                          'Subtotal: \Rp${strukList[index]['subtotal'].toString()}'),
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
