// lib/screens/add_character_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/rpg_provider.dart';

class AddCharacterScreen extends StatefulWidget {
  const AddCharacterScreen({super.key});

  @override
  State<AddCharacterScreen> createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _levelController = TextEditingController();

  void _save() {
    if (_nameController.text.isEmpty || _classController.text.isEmpty || _levelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos!'), backgroundColor: Colors.red));
      return;
    }

    final newChar = Character(
      id: DateTime.now().toString(),
      name: _nameController.text,
      charClass: _classController.text,
      level: int.tryParse(_levelController.text) ?? 1,
    );

    Provider.of<RpgProvider>(context, listen: false).addCharacter(newChar);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personagem criado!'), backgroundColor: Colors.green));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Personagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _classController, decoration: const InputDecoration(labelText: 'Classe', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _levelController, decoration: const InputDecoration(labelText: 'Nível', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                onPressed: _save,
                child: const Text('Salvar Personagem')
            )
          ],
        ),
      ),
    );
  }
}