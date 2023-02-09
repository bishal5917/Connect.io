import 'package:chat_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nextFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  var loginDetail = {'email': "", 'pass': ""};

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

  Widget build(BuildContext context) {
    final authproviders = Provider.of<Auth>(context);
    final errorMessage = authproviders.errorMessage;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 67, 108),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Hello There !",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    // controller: emailInput,
                    decoration: InputDecoration(
                        hintText: "Email", border: InputBorder.none),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(nextFocus);
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
                    onSaved: (val) {
                      loginDetail['email'] = val as String;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    // controller: passInput,
                    decoration: InputDecoration(
                        hintText: "Password", border: InputBorder.none),
                    textInputAction: TextInputAction.next,
                    focusNode: nextFocus,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please enter your password!";
                      }
                      if (value.length < 5) {
                        return "Password should contain at least 5 characters";
                      }
                      return null;
                    }),
                    onSaved: (val) {
                      loginDetail['pass'] = val as String;
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    saveForm();
                    if (loginDetail['email']!.isNotEmpty &&
                        loginDetail['pass']!.isNotEmpty) {
                      authproviders.Login(loginDetail['email'] as String,
                          loginDetail['pass'] as String);
                      if (errorMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Container(
                                padding: EdgeInsets.all(16),
                                height: 90,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.red),
                                child: Column(
                                  children: [
                                    Text(
                                      "Oops ! ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(errorMessage,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                ))));
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/goto_register');
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Color.fromARGB(255, 125, 228, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
