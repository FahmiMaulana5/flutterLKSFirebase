import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lks_jabar_2023/function.dart';

class Register_Page extends StatefulWidget {
  const Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {

  bool _isObscure = true;

  bool _isObscure2 = true;

  Func f = Func();

  File? _image;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    final XFile? _imagePicked = await _picker.pickImage(source: ImageSource.gallery);
    _image = File(_imagePicked!.path);
    setState(() {
      
    });
  }

  final _namaLengkapController = TextEditingController();
  final _usernameController = TextEditingController();
  final _alamatkapController = TextEditingController();
  final _teleponLengkapController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text(
                  'Silahkan isi data pribadi anda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                (_image != null)
                  ?  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover
                        )
                      ),
                      height: 120,
                      width: 120,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      height: 120,
                      width: 120,
                    ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _namaLengkapController,
                  style: TextStyle(
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _usernameController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _alamatkapController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Alamat',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _teleponLengkapController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Telepon',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon( _isObscure ? Icons.visibility_off : Icons.visibility , size: 30,)
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                 SizedBox(height: 10,),
                TextFormField(
                  obscureText: _isObscure2,
                  controller: _konfirPasswordController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      onPressed: (){
                       setState(() {
                         _isObscure2 = !_isObscure2;
                       });
                      }, 
                      icon: Icon( _isObscure2 ? Icons.visibility_off : Icons.visibility, size: 30,)
                    ),
                    hintText: 'Konfirmasi Password',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey)
                    ),
                    onPressed: () async {
                      getImage();
                    },
                    child: Text('Pilih foto profile', style: TextStyle(fontSize: 20),)
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                    ),
                    onPressed: () async{
                        if (_namaLengkapController.text.isEmpty || _usernameController.text.isEmpty || _alamatkapController.text.isEmpty || _teleponLengkapController.text.isEmpty || _passwordController.text.isEmpty || _konfirPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Semua kolom harus di isi!'),
                              duration: Duration(
                                seconds: 2
                              ),
                            )
                          );
                        }else{
                          if ( _konfirPasswordController.text != _passwordController.text ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Konfirmasi password salah!'),
                                duration: Duration(
                                  seconds: 3
                                ),
                              )
                            );
                          }else{
                            await f.addUser(
                              _usernameController.text,
                              _passwordController.text,
                              _namaLengkapController.text,
                              _alamatkapController.text,
                              _teleponLengkapController.text,
                              _image, 
                              context
                            );
                              _usernameController.clear();
                              _passwordController.clear();
                              _namaLengkapController.clear();
                              _alamatkapController.clear();
                              _teleponLengkapController.clear();
                              _konfirPasswordController.clear();
                              _image = File("");
                          }
                        }
                    },
                    child: Text('Daftar', style: TextStyle(fontSize: 20),)
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.lightBlueAccent)
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/Login_Page');
                    }, 
                    child: Text('Sudah punya akun', style: TextStyle(fontSize: 20),)
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}