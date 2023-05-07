import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lks_jabar_2023/function.dart';
import 'package:lks_jabar_2023/itemData.dart';
import 'package:lks_jabar_2023/listItem.dart';

class Menu_Page extends StatefulWidget {
  const Menu_Page({super.key});

  @override
  State<Menu_Page> createState() => _Menu_PageState();
}

class _Menu_PageState extends State<Menu_Page> {

  listItem list = listItem();

  String searchQuery = '';

  Func f = Func();

  static int jum1 = 0;
  static int jum2 = 0;
  static int jum3 = 0;

  static int price1 = 0;
  static int price2 = 0;
  static int price3 = 0;

  static int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('MenuFood XYZ', style: TextStyle(fontSize: 20, color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  hintText: 'Cari Item',
                  suffixIcon: Icon(Icons.search, size: 30,),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                  )
                ),
              ),
              SizedBox(height: 20,),
              Text('Semua', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Container(
                height: 325,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('menus').where('namaItem', isGreaterThanOrEqualTo: searchQuery).where('namaItem', isLessThan: searchQuery + 'z').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        list.items.clear();
                        for (int index = 0; index < snapshot.data!.docs.length; index++) {
                          DocumentSnapshot _document = snapshot.data!.docs[index];
                          if (index == 0) {
                            if (jum1 != 0) {
                              list.items.add(Item(namaItem: _document['namaItem'], hargaItem: _document['hargaItem'], jumlahItem: jum1, totalHarga: price1));
                            }
                          } else if (index == 1) {
                            if(jum2 != 0){
                              list.items.add(Item(namaItem: _document['namaItem'], hargaItem: _document['hargaItem'], jumlahItem: jum2, totalHarga: price2));
                            }
                          } else if (index == 2) {
                            if (jum3 != 0) {
                              list.items.add(Item(namaItem: _document['namaItem'], hargaItem: _document['hargaItem'], jumlahItem: jum3, totalHarga: price3));
                            }
                          }
                        }
                        String check = index.toString();
                        return Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(document['gambar'])
                                  )
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['namaItem'],
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Rp. ${document['hargaItem'].toString()}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            switch (check) {
                                              case '0':
                                                jum1--;
                                                int har = document['hargaItem'];
                                                price1 = price1 - har;
                                                if(price1 == -har){
                                                  price1 = price1 + har;
                                                }
                                                if (jum1 == -1) {
                                                  jum1 ++;
                                                }
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              case '1':
                                                jum2--;
                                                int har = document['hargaItem'];
                                                price2 = price2 - har;
                                                if(price2 == -har){
                                                  price2 = price2 + har;
                                                }
                                                if (jum2 == -1) {
                                                  jum2 ++;
                                                }
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              case '2':
                                                jum3--;
                                                 int har = document['hargaItem'];
                                                price3 = price3 - har;
                                                if(price3 == -har){
                                                  price3 = price3 + har;
                                                }
                                                if (jum3 == -1) {
                                                  jum3 ++;
                                                }
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              default:
                                            }
                                          });
                                        }, 
                                        icon: Icon(Icons.remove_circle_outline, size: 17,)
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        check == '0'
                                        ? jum1.toString()
                                        : check == '1'
                                          ? jum2.toString()
                                          : jum3.toString(), 
                                        style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold
                                          ),
                                      ),
                                      SizedBox(width: 5,),
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            switch (check) {
                                              case '0':
                                                jum1++;
                                                price1 = document['hargaItem'] * jum1;
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              case '1':
                                                jum2++;
                                                price2 = document['hargaItem'] * jum2;
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              case '2':
                                                jum3++;
                                                price3 = document['hargaItem'] * jum3;
                                                totalPrice = price1 + price2 + price3;
                                                break;
                                              default:
                                            }
                                          });
                                        }, 
                                        icon: Icon(Icons.add_circle_outline, size: 17,)
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(width: 120,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,size: 15,color: Colors.yellow,),
                                      Text('${document['rate']}', style: TextStyle(fontSize: 12),)
                                    ],
                                  ),
                                  SizedBox(height: 48,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.lightBlueAccent,
                                    child: Icon(Icons.trolley, color: Colors.white,),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide.none
                )
              )
            ),
            onPressed: () async {
              if(totalPrice == 0){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pilih terlebih dalulu item!'),
                    duration: Duration(
                      seconds: 2
                    ),
                  )
                );
              }else{
              Navigator.pushNamed(context, '/Invoice_Page', arguments: list.items);
              f.addTran(list.items, context);
              jum1 = 0;
              jum2 = 0;
              jum3 = 0;
              price1 = 0;
              price2 = 0;
              price3 = 0;
              totalPrice = 0;
              }
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bayar Sekarang', style: TextStyle(fontSize: 15),),
                Text('Rp. ${totalPrice.toString()}', style: TextStyle(fontSize: 15), textAlign: TextAlign.left,),
              ],
            )
          ),
        ),
      ),
    );
  }
}