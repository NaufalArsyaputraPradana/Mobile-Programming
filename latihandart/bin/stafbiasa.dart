import 'karyawan.dart';

class StafBiasa extends Karyawan {
  StafBiasa(super.npp, super.nama, {thnMasuk = 2015});

  @override
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang terlambat");
    } else {
      print("$nama pada ${dateFormat.format(jamMasuk)} datang tepat waktu");
    }
  }

  @override
  // TODO: implement tunjangan
  int get tunjangan => ((2023 - thnMasuk) < 5) ? 50000 : 100000;
}
