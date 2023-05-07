import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lks_jabar_2023/Profile_Page.dart';
import 'package:lks_jabar_2023/function.dart';
import 'package:lks_jabar_2023/userData.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  Func f = Func();

  bool _isObscure = true;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/burger.png'),
                    fit: BoxFit.fill,
                  ),
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    isDense: true, 
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
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
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontSize: 20
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }, 
                      icon: Icon( _isObscure ? Icons.visibility_off : Icons.visibility, size: 30,)
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 0, 90, 163))
                    ),
                    onPressed: () async {
                      if ( _usernameController.text.isEmpty || _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Semua kolom harus di isi!'),
                            duration: Duration(
                              seconds: 3
                            ),
                          )
                        );
                      }else{
                        await f.login(
                          _usernameController.text, 
                          _passwordController.text,
                          context
                        );
                        userData.username = _usernameController.text;
                      }
                    }, 
                    child: Text('Login', style: TextStyle(fontSize: 20),),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 103, 207, 255))
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Register_Page');
                    }, 
                    child: Text('Daftar', style: TextStyle(fontSize: 20),)
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}