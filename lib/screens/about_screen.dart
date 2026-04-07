// lib/screens/about_screen.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o Projeto')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Gerenciador de RPG', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Objetivo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Aplicativo desenvolvido para gerenciar fichas de personagens de RPG de mesa, rolar dados e facilitar a vida dos jogadores, servindo como projeto prático universitário.'),
            SizedBox(height: 24),
            Text('Equipe de Desenvolvimento:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('• Arthur Melo - Engenharia de Software\n'),
            Text('• Gabriel Justino - Engenharia de Software\n'),
            Text('• Hugo Alves - Engenharia de Software \n '),
            SizedBox(height: 24),
            Text('Instituição / Disciplina:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('UNAERP / Mobile II'),
            Spacer(),
            Center(child: Text('Versão 1.0.0', style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}