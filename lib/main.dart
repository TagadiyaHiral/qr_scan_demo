import 'package:flutter/material.dart';
import 'package:qr_scan_demo/home_screen.dart';
import 'package:qr_scan_demo/sqlLite/sql_provider.dart';
import 'package:qr_scan_demo/sqlLite/user_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final db= await initdatabase;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: UserScreen(),
    );
  }
}

