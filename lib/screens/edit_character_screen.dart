// lib/screens/edit_character_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/rpg_provider.dart';

class EditCharacterScreen extends StatefulWidget {
  final Character character;
  const EditCharacterScreen({super.key, required this.character});

  @override
  State<EditCharacterScreen> createState() => _EditCharacterScreenState();
}

class _EditCharacterScreenState extends State<EditCharacterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _classController;
  late TextEditingController _levelController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.character.name);
    _classController = TextEditingController(text: widget.character.charClass);
    _levelController = TextEditingController(text: widget.character.level.toString());
  }

  void _update() {
    final updatedChar = Character(
      id: widget.character.id,
      name: _nameController.text,
      charClass: _classController.text,
      level: int.tryParse(_levelController.text) ?? widget.character.level,
      // INCLUSÃO NECESSÁRIA PARA NÃO APAGAR OS STATUS E ITENS
      hp: widget.character.hp,
      maxHp: widget.character.maxHp,
      mana: widget.character.mana,
      maxMana: widget.character.maxMana,
      inventory: widget.character.inventory,
    );

    Provider.of<RpgProvider>(context, listen: false).updateCharacter(updatedChar);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personagem atualizado!'), backgroundColor: Colors.blue));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Personagem')),
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
                onPressed: _update,
                child: const Text('Atualizar Personagem')
            )
          ],
        ),
      ),
    );
  }
}