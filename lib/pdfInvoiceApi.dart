import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:lks_jabar_2023/invoice.dart';
import 'package:lks_jabar_2023/pdfApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = pw.Document();
    final robotoFont = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    final invoiceTable = buildInvoice(invoice, robotoFont);

    pdf.addPage(pw.MultiPage(
      build: (pw.Context context) => [
        invoiceTable,
      ],
    ));
    return PdfApi.saveDocument(name: 'Invoice.pdf', pdf: pdf);
  }

  static pw.Widget buildInvoice(Invoice invoice, pw.Font font) {
    final headers = [
      'Nama',
      'Harga',
      'Jumlah',
      'Subtotal',
    ];
    final data = invoice.items.map((item) {
      return [
        item.namaItem,
        item.hargaItem,
        item.jumlahItem,
        item.subtotal
      ];
    }).toList();
    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontSize: 20, font: font),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      cellStyle: pw.TextStyle(font: font)
    );
  }
}