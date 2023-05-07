
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lks_jabar_2023/itemData.dart';
import 'package:lks_jabar_2023/userData.dart';

class Func {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  
  Future<void> addUser(String userName, String password, String namaLengkap, String alamat, String telepon, File? fotoProfile, BuildContext context) async{
    try{

      String? _fotoProfileUrl;
      String _kosong = "Kosong";

      if (fotoProfile != null) {
        Reference _storageReference = _storage.ref().child('fotoProfile/${DateTime.now().millisecondsSinceEpoch}.png');
        UploadTask _uploadTask = _storageReference.putFile(fotoProfile);
        TaskSnapshot _taskSnapshot = await _uploadTask;
        _fotoProfileUrl = await _taskSnapshot.ref.getDownloadURL();
      }
      
      CollectionReference _collectionReference = _firestore.collection('users');
      await _collectionReference.add({
        'username': userName,
        'password': password,
        'namaLengkap': namaLengkap,
        'alamat': alamat,
        'telepon': telepon,
        'fotoProfile': _fotoProfileUrl != null ? _fotoProfileUrl : _kosong
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User berhasil di tambahkan!'),
          duration: Duration(
            seconds: 3
          ),
        )
      );
    }catch (e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(
            seconds: 2
          ),
        )
      );
    }
  }

  Future<void> login( String username, String password, BuildContext context) async {
    try{

      CollectionReference _collectionReference = _firestore.collection('users');
      QuerySnapshot querySnapshot = await _collectionReference.where('username', isEqualTo: username).where('password', isEqualTo: password).get();

      if(querySnapshot.docs.length > 0){
        userData.documentId = querySnapshot.docs[0].id;
        Navigator.pushReplacementNamed(context, '/Navbar');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username atau password tidak ditemukan!'),
            duration: Duration(
              seconds: 2
            ),
          )
        );
        return;
      }

    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(
            seconds: 2
          ),
        )
      );
    }
  }

  Future<void> addTran(List<Item> items, BuildContext context)async{
    try {
      CollectionReference _collectionReference = _firestore.collection('transaksi');
      List<Map<String, dynamic>> itemList = [];
      int total = items.fold(0, (previousValue, item) => previousValue + item.totalHarga);
      for (var i = 0; i < items.length; i++) {
        itemList.add({
          'namaItem': items[i].namaItem,
          'hargaItem': items[i].hargaItem.toString(),
          'jumlahItem': items[i].jumlahItem.toString(),
          'subtotal': items[i].totalHarga.toString()
        });
      }
      await _collectionReference.add({
        'userId': userData.documentId,
        'itemDibeli': itemList,
        'totalPembayaran': total.toString()
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaksi sudah terekam di database'),
          duration: Duration(seconds: 2),
        )
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
        )
      );
    }
  }

}