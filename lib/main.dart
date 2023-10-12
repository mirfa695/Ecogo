import 'package:ecogo/provider/home_provider.dart';
import 'package:ecogo/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomeProvider(),
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 2,
      )),
    );
  }
}
