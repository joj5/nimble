import 'package:flutter/material.dart';
import 'package:frontend/modules/shared/ui/splash/splash_screen.dart';
import 'package:frontend/viewmodels/auth_view_model.dart';
import 'package:frontend/viewmodels/inventory_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => InventoryViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: true,
      home: const SplashScreen(),
    );
  }
}
