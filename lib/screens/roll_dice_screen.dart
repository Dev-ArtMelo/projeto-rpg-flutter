// lib/screens/roll_dice_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen({super.key});

  @override
  State<RollDiceScreen> createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  int _selectedDice = 20; // Padrão D20
  int _quantity = 1;
  List<int> _results = [];
  int _total = 0;

  final List<int> _diceTypes = [4, 6, 8, 10, 12, 20, 100];

  void _rollDice() {
    final random = Random();
    List<int> newResults = [];
    int newTotal = 0;

    for (int i = 0; i < _quantity; i++) {
      int roll = random.nextInt(_selectedDice) + 1;
      newResults.add(roll);
      newTotal += roll;
    }

    setState(() {
      _results = newResults;
      _total = newTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taverna dos Dados')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dado', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<int>(
                      value: _selectedDice,
                      items: _diceTypes.map((dice) {
                        return DropdownMenuItem(value: dice, child: Text('D$dice'));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedDice = val!),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Quantidade', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(icon: const Icon(Icons.remove), onPressed: () => setState(() { if (_quantity > 1) _quantity--; })),
                        Text('$_quantity', style: const TextStyle(fontSize: 18)),
                        IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _quantity++)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            if (_results.isNotEmpty) ...[
              const Text('Resultado Total:', style: TextStyle(fontSize: 20)),
              Text('$_total', style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 10),
              Text('Rolagens: ${_results.join(" + ")}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _rollDice,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              icon: const Icon(Icons.casino, size: 28),
              label: const Text('Rolar Dados', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}