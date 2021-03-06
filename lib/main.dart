import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users List',
      theme: ThemeData(
        brightness:  Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: AuthPage(),
    );
  }
}

