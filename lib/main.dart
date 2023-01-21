import 'package:chat_app/Screens/Chat.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/providers/auth.dart';
import 'package:chat_app/providers/conversations.dart';
import 'package:chat_app/providers/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final authproviders = Provider.of<Auth>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Conversations(),
        ),
        ChangeNotifierProvider.value(
          value: Messages(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // theme:
          //     ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Lato'),
          home: auth.checkUser ? HomeScreen() : LoginScreen(),
          routes: {
            '/open_chat': (context) => Chat(),
          },
        ),
      ),
    );
  }
}
