import 'package:deliveryapp/screens/AddressSearch_screen.dart';
import 'package:deliveryapp/screens/addressEdit_screen.dart';
import 'package:deliveryapp/screens/home_screen.dart';
import 'package:deliveryapp/screens/join_screen.dart';
import 'package:deliveryapp/screens/login_screen.dart';
import 'package:deliveryapp/screens/search_screen.dart';
import 'package:deliveryapp/screens/userEdit_screen.dart';
import 'package:deliveryapp/screens/userInfo_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'delivery app',
      initialRoute: "/home",
      routes: {
        '/home': (context) => const HomeScreen(),
        '/addressEdit': (context) => AddressScreen(),
        '/join': (context) => const JoinScreen(),
        '/login': (context) => const LoginScreen(),
        '/search': (context) => const SearchScreen(),
        '/userEdit': (context) => const UserEditScreen(),
        '/userInfo': (context) => const UserInfoScreen(),
        '/addressSearch': (context) => const AddressSearchScreen(),
      },
    );
  }
}
