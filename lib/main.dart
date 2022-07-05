import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:people_of_meal/provider/school_data_provider.dart';
import 'package:people_of_meal/screen/route_page.dart';
import 'package:people_of_meal/screen/login_page.dart';
import 'package:people_of_meal/services/firebase_services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // runApp(const MyApp());

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SchoolDataProvider())
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}