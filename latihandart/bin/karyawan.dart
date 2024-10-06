import 'package:intl/intl.dart';

const UMR = 2900000;
var numFormat = NumberFormat("#,###,000");
var dateFormat = DateFormat('yyyy-MM-dd');

abstract class Karyawan {
  String npp; //not nullable
  String nama;
  String? alamat; //nullable
  int thnMasuk;
  int _gaji = 2900000;

  void presensi(DateTime jamMasuk);

  String deskripsi() {
    String teks = "===================\n";
    teks += "NPP: $npp\n";
    teks += "Nama: $nama\n";
    teks += "Gaji: ${numFormat.format(gaji)}\n"; // Menggunakan numFormat
    if (alamat != null) {
      teks += "Alamat: $alamat\n";
    }
    return teks;
  }

  int get tunjangan => ((2023 - thnMasuk) < 5) ? 50000 : 100000;
  int get gaji => (_gaji + tunjangan);

  set gaji(int gaji) {
    if (gaji < UMR) {
      _gaji = UMR;
      print("Gaji tidak boleh dibawah UMR");
    } else {
      _gaji = gaji;
    }
  }

  Karyawan(this.npp, this.nama, {this.thnMasuk = 2015, this.alamat});
}
