
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/rpg_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RpgProvider()),
      ],
      child: const RpgManagerApp(),
    ),
  );
}

class RpgManagerApp extends StatelessWidget {
  const RpgManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RpgProvider>(context); // Escuta o Provider

    return MaterialApp(
      title: 'Gerenciador de RPG',
      // Tema Claro
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      // Tema Escuro
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: provider.themeMode, // Define o tema atual dinamicamente
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}