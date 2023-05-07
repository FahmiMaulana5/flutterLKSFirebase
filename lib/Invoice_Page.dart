import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lks_jabar_2023/invoice.dart';
import 'package:lks_jabar_2023/itemData.dart';
import 'package:lks_jabar_2023/listItem.dart';
import 'package:lks_jabar_2023/pdfApi.dart';
import 'package:lks_jabar_2023/pdfInvoiceApi.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';



class Invoice_Page extends StatefulWidget {

  const Invoice_Page({super.key});

  @override
  State<Invoice_Page> createState() => _Invoice_PageState();
}

class _Invoice_PageState extends State<Invoice_Page> {

  int totalHarga = 0;

  @override
  Widget build(BuildContext context) {
    final List<Item> items = ModalRoute.of(context)!.settings.arguments as List<Item>;
    Future<void> _printPdf() async {

      pw.Widget buildTable() {
        List<pw.TableRow> tableRows = [];

        // Add table header
        tableRows.add(pw.TableRow(
          children: [
            pw.Center(child: pw.Text('Nama Item', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),),
            pw.Center(child: pw.Text('Harga', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),),
            pw.Center(child: pw.Text('Jumlah', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),),
            pw.Center(child: pw.Text('Subtotal', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),)
          ],
        ));

        // Add table rows
        for (var item in items) {
          tableRows.add(pw.TableRow(
            children: [
              pw.Text(item.getNamaItem, style: pw.TextStyle(fontSize: 20)),
              pw.Center(child: pw.Text('Rp. ${item.getHargaItem.toString()}', style: pw.TextStyle(fontSize: 20))),
              pw.Center(child: pw.Text(item.getJumlahItem.toString(), style: pw.TextStyle(fontSize: 20))),
              pw.Center(child: pw.Text('Rp. ${item.getTotalHarga.toString()}', style: pw.TextStyle(fontSize: 20))),
            ],
          ));
        }

        // Add table footer
        tableRows.add(pw.TableRow(
          children: [
            pw.SizedBox(),
            pw.SizedBox(),
            pw.Center(child: pw.Text('Total Harga: ', style: pw.TextStyle(fontSize: 20))),
            pw.Center(child: pw.Text('Rp. ${totalHarga.toString()}', style: pw.TextStyle(fontSize: 20))),
          ],
        ));

        return pw.Table(
          border: pw.TableBorder.all(),
          children: tableRows,
        );
      }

      final pdf = pw.Document();

      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Invoice', style: pw.TextStyle(fontSize: 30)),
                pw.SizedBox(height: 20,),
                buildTable()
              ]
            )
          );
        },
      ));

      final bytes = await pdf.save();

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
      );
    }

    Future<void> _sharePdf() async {

      final pdf = pw.Document();
      final font = await PdfGoogleFonts.nunitoExtraLight();

      pw.Widget buildTable() {
        List<pw.TableRow> tableRows = [];

        // Add table header
        tableRows.add(pw.TableRow(
          children: [
            pw.Center(child: pw.Text('Nama Item', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, font: font)),),
            pw.Center(child: pw.Text('Harga', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, font: font)),),
            pw.Center(child: pw.Text('Jumlah', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, font: font)),),
            pw.Center(child: pw.Text('Subtotal', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, font: font)),)
          ],
        ));

        // Add table rows
        for (var item in items) {
          tableRows.add(pw.TableRow(
            children: [
              pw.Text(item.getNamaItem, style: pw.TextStyle(fontSize: 20)),
              pw.Center(child: pw.Text('Rp. ${item.getHargaItem.toString()}', style: pw.TextStyle(fontSize: 20, font: font))),
              pw.Center(child: pw.Text(item.getJumlahItem.toString(), style: pw.TextStyle(fontSize: 20, font: font))),
              pw.Center(child: pw.Text('Rp. ${item.getTotalHarga.toString()}', style: pw.TextStyle(fontSize: 20, font: font))),
            ],
          ));
        }

        // Add table footer
        tableRows.add(pw.TableRow(
          children: [
            pw.SizedBox(),
            pw.SizedBox(),
            pw.Center(child: pw.Text('Total Pembayaran: ', style: pw.TextStyle(fontSize: 20, font: font))),
            pw.Center(child: pw.Text('Rp. ${totalHarga.toString()}', style: pw.TextStyle(fontSize: 20, font: font))),
          ],
        ));

        return pw.Table(
          border: pw.TableBorder.all(),
          children: tableRows,
        );
      }

      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Invoice', style: pw.TextStyle(fontSize: 30, font: font)),
                pw.SizedBox(height: 20,),
                buildTable()
              ]
            )
          );
        },
      ));

      final bytes = await pdf.save();

      final fileName = 'invoice.pdf';
      final filePath = '${await getTemporaryDirectory()}/$fileName';
      final File file = File(filePath);
      await file.writeAsBytes(bytes);

      await Share.shareFiles(
        [fileName],
        text: 'Check out this PDF file!',
        subject: 'PDF Document',
        mimeTypes: ['application/pdf'],
      );
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Text('Invoice', style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: DataTable(
              dividerThickness: 0,
              columns: [
                DataColumn(label: Text('Nama', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Harga', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Jumlah', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Subtotal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
              ],
              rows: items.map((item) {
                totalHarga = items.fold(0, (previousValue, item) => previousValue + item.getTotalHarga);
                return DataRow(cells: [
                  DataCell(Text(item.getNamaItem, style: TextStyle(fontSize: 10))),
                  DataCell(Center(child: Text('Rp. ${item.getHargaItem.toString()}', style: TextStyle(fontSize: 10),))),
                  DataCell(Center(child: Text(item.getJumlahItem.toString(), style: TextStyle(fontSize: 10)))),
                  DataCell(Center(child: Text('Rp. ${item.getTotalHarga.toString()}', style: TextStyle(fontSize: 10)))),
                ]);
              }).toList(),
            ),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Pembayaran', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  Text('Rp. ${totalHarga.toString()}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 155,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                    ),
                    onPressed: () async { 
                      _printPdf();
                    },
                    child: Text('Save', style: TextStyle(fontSize: 20),)
                  ),
                ),
                SizedBox(width: 10,),
                 SizedBox(
                  width: 155,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                    ),
                    onPressed: () { 
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Fitur belum tersedia'),
                      //     duration: Duration(seconds: 3),
                      //   )
                      // );
                      _sharePdf();
                    },
                    child: Text('Share', style: TextStyle(fontSize: 20),)
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            SizedBox(width: 10,),
            SizedBox(
              width: 320,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                ),
                onPressed: () { 
                  Navigator.pushReplacementNamed(context, '/Navbar');
                },
                child: Text('Selesai', style: TextStyle(fontSize: 20),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  
