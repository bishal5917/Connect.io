import 'package:chat_app/providers/auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPass = false;
  File? file;
  ImagePicker imgP = ImagePicker();

  final nextFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  var registerDetail = {'username': "", 'email': "", 'pass': "", 'profPic': ""};

  void initState() {
    Future.delayed(Duration.zero).then((value) {
      final authproviders = Provider.of<Auth>(context, listen: false);
      if (authproviders.checkUser) {
        Navigator.of(context).pushNamed('/');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nextFocus.dispose();
  }

  void saveForm() {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
    }
  }

  getgall() async {
    // ignore: deprecated_member_use
    var img = await imgP.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img.path);
      registerDetail['profPic'] = img.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authproviders = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 67, 108),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "Create New Account",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: file == null
                            ? Icon(
                                Icons.image,
                                size: 50,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(file!), radius: 20),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              getgall();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 24, 122, 155),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.white),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.red,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    onSaved: (val) {
                      registerDetail['username'] = val as String;
                    },
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please choose a username!";
                      }
                      return null;
                    }),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: "Username",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Choose a unique username ...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    onSaved: (val) {
                      registerDetail['email'] = val as String;
                    },
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please enter your email!";
                      }
                      if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value)) {
                        return "Please enter valid email address";
                      }
                      return null;
                    }),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your Email ...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please choose a strong password!";
                      }
                      if (value.length < 5) {
                        return "Password should contain at least 5 characters";
                      }
                      return null;
                    }),
                    onSaved: (val) {
                      registerDetail['pass'] = val as String;
                    },
                    obscureText: showPass == true ? false : true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: showPass == false
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                          onPressed: (() {
                            setState(() {
                              if (showPass == false) {
                                showPass = true;
                              } else {
                                showPass = false;
                              }
                            });
                          }),
                        ),
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Select a strong password ...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        saveForm();
                        // print(registerDetail);
                        if (registerDetail['username']!.isNotEmpty &&
                            registerDetail['email']!.isNotEmpty &&
                            registerDetail['pass']!.isNotEmpty) {
                          authproviders.RegisterUser(
                              registerDetail['username'] as String,
                              registerDetail['email'] as String,
                              registerDetail['pass'] as String,
                              registerDetail['profPic'] as String);
                          if (authproviders.checkUser) {
                            Navigator.of(context).pushNamed('/');
                          }
                        }
                        // setState(() {
                        //   errorMessage = authproviders.errorMessage;
                        // });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 109, 159),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/goto_login');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "<- Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 21, 118, 125),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
