// import 'package:chat_app/Screens/Chat.dart';
// import 'package:chat_app/Screens/HomeScreen.dart';
// import 'package:chat_app/Screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   @override
//   final user = true;
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Chat App',
//         home: !user ? HomeScreen() : LoginScreen(),
//         routes: {
//           '/open_chat': (context) => Chat(),
//         });
//   }
// }
import 'package:chat_app/Screens/Chat.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/providers/auth.dart';
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
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
