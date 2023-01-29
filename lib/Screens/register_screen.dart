import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 67, 108),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://i.pinimg.com/originals/a0/49/9a/a0499a21a66b84cb420b38f95ed1cd56.png"))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 24, 122, 155),
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.red,
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
                  decoration: InputDecoration(
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
                      // saveForm();
                      // authproviders.Login(loginDetail['email'] as String,
                      //     loginDetail['pass'] as String);
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
    );
  }
}
