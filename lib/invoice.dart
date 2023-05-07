class Invoice {
  
  final List<InvoiceItem> items;

  const Invoice({
    required this.items,
  });
}

class InvoiceItem {
  final String namaItem;
  final String hargaItem;
  final String jumlahItem;
  final String subtotal;

  const InvoiceItem({
    required this.namaItem,
    required this.hargaItem,
    required this.jumlahItem,
    required this.subtotal
  });
}