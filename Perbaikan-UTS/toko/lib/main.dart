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
          'harga': barangList[index]['harga'],
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Toko Komputer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  barangList[index]['nama'],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text('Harga: Rp${barangList[index]['harga']}'),
                              ],
                            ),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: controllers[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: reset,
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: cetakStruk,
                      child: const Text(
                        "Cetak Struk",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: strukList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Colors.blue[300],
                      ),
                      title: Text(
                        strukList[index]['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Jumlah: ${strukList[index]['jumlah']} x Rp${strukList[index]['harga']}'),
                      trailing: Text(
                          'Subtotal: Rp${strukList[index]['subtotal'].toString()}'),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                color: Colors.lightBlue[100],
                child: Text(
                  "Total Bayar : Rp${totalBayar}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
