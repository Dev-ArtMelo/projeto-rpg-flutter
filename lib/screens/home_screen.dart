// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rpg_provider.dart';
import 'add_character_screen.dart';
import 'character_detail_screen.dart';
import 'roll_dice_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta o Provider para atualizar a lista de personagens e o ícone do tema
    final provider = Provider.of<RpgProvider>(context);
    final characters = provider.characters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Personagens'),
        actions: [
          // Botão de Tema (Dark/Light Mode)
          IconButton(
            icon: Icon(provider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            tooltip: 'Alternar Tema',
            onPressed: () {
              Provider.of<RpgProvider>(context, listen: false).toggleTheme();
            },
          ),
          // Botão de Rolagem de Dados
          IconButton(
            icon: const Icon(Icons.casino),
            tooltip: 'Rolar Dados',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RollDiceScreen())),
          ),
          // Botão Sobre
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
          // Botão de Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              // Limpa o usuário atual da memória
              Provider.of<RpgProvider>(context, listen: false).logout();

              // Navega para o Login e apaga o histórico de telas
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false
              );
            },
          ),
        ],
      ),
      body: characters.isEmpty
          ? const Center(child: Text('Nenhum personagem cadastrado.'))
          : ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final char = characters[index];
          return ListTile(
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.white)
            ),
            title: Text(char.name),
            subtitle: Text('Classe: ${char.charClass} | Nível: ${char.level}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => CharacterDetailScreen(character: char),
              ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCharacterScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}