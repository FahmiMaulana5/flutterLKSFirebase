class Item {
  String namaItem;
  int hargaItem;
  int jumlahItem;
  int totalHarga;

  Item({required this.namaItem, required this.hargaItem, required this.jumlahItem, required this.totalHarga});

  String get getNamaItem => namaItem;
  int get getHargaItem => hargaItem;
  int get getJumlahItem => jumlahItem;
  int get getTotalHarga => totalHarga;
}
