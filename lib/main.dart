import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'package:provider/provider.dart';
import 'provider/CartProvider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_)=,)
        ChangeNotifierProvider(create: (_)=>CartProvider())
      ],
      child: MaterialApp(
       initialRoute: '/',
       onGenerateRoute: onGenerateRoute,
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primaryColor: Colors.white
       ),
      )
       
    );

  }
}