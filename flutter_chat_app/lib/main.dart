import 'package:flutter/material.dart';

import 'src/screens/chat/chat_screen.dart';
import 'src/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/chat': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;

          return ChatPage(
            name: args['name'],
            room: args['room'],
          );
        },
      },
    );
  }
}
