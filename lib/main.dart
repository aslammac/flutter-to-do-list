import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home/home.dart';

void main() => runApp(MyAppHome());
// WidgetsFlutterBinding.ensureInitialized();
// SystemChrome.setPreferredOrientations([
//   DeviceOrientation.portraitDown,
//   DeviceOrientation.portraitUp,
// ]);

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(),
              headline6: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              )),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            color: Colors.white,
            brightness: Brightness.dark,
            actionsIconTheme: IconThemeData(
              color: Colors.black38,
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontSize: 22,
                )),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor:
                Theme.of(context).floatingActionButtonTheme.backgroundColor,
            elevation: 0,
          )),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}
