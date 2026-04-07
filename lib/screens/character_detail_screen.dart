// lib/screens/character_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../providers/rpg_provider.dart';
import 'edit_character_screen.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailScreen({super.key, required this.character});

  // Função para alterar HP e Mana
  void _changeStat(BuildContext context, Character char, String stat, int amount) {
    if (stat == 'hp') char.hp = (char.hp + amount).clamp(0, char.maxHp);
    if (stat == 'mana') char.mana = (char.mana + amount).clamp(0, char.maxMana);
    Provider.of<RpgProvider>(context, listen: false).updateCharacter(char);
  }

  // Função para remover item
  void _removeItem(BuildContext context, Character char, String item) {
    char.inventory.remove(item);
    Provider.of<RpgProvider>(context, listen: false).updateCharacter(char);
  }

  // Caixa de diálogo para adicionar item
  void _showAddItemDialog(BuildContext context, Character char) {
    final _itemController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Novo Item'),
          content: TextField(
            controller: _itemController,
            decoration: const InputDecoration(hintText: 'Nome do item (ex: Poção de Cura)', border: OutlineInputBorder()),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                if (_itemController.text.trim().isNotEmpty) {
                  char.inventory.add(_itemController.text.trim());
                  Provider.of<RpgProvider>(context, listen: false).updateCharacter(char);
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RpgProvider>(context);
    final currentChar = provider.characters.firstWhere((c) => c.id == character.id, orElse: () => character);

    return Scaffold(
      appBar: AppBar(title: Text(currentChar.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CARD DE ATRIBUTOS (HP e Mana)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Atributos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                    const Divider(),
                    Text('Classe: ${currentChar.charClass} | Nível: ${currentChar.level}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('HP (Vida)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.remove_circle, color: Colors.red), onPressed: () => _changeStat(context, currentChar, 'hp', -1)),
                            Text('${currentChar.hp} / ${currentChar.maxHp}', style: const TextStyle(fontSize: 18)),
                            IconButton(icon: const Icon(Icons.add_circle, color: Colors.green), onPressed: () => _changeStat(context, currentChar, 'hp', 1)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Mana (MP)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.remove_circle, color: Colors.red), onPressed: () => _changeStat(context, currentChar, 'mana', -1)),
                            Text('${currentChar.mana} / ${currentChar.maxMana}', style: const TextStyle(fontSize: 18)),
                            IconButton(icon: const Icon(Icons.add_circle, color: Colors.green), onPressed: () => _changeStat(context, currentChar, 'mana', 1)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // CARD DE INVENTÁRIO
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Inventário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.green, size: 28),
                          onPressed: () => _showAddItemDialog(context, currentChar),
                          tooltip: 'Adicionar Item',
                        ),
                      ],
                    ),
                    const Divider(),
                    currentChar.inventory.isEmpty
                        ? const Padding(padding: EdgeInsets.all(8.0), child: Text('O inventário está vazio.'))
                        : Column(
                      children: currentChar.inventory.map((item) => ListTile(
                        leading: const Icon(Icons.backpack),
                        title: Text(item),
                        dense: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _removeItem(context, currentChar, item),
                        ),
                      )).toList(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => EditCharacterScreen(character: currentChar))),
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Provider.of<RpgProvider>(context, listen: false).removeCharacter(currentChar.id);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Excluir', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}