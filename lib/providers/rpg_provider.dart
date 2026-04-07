// lib/providers/rpg_provider.dart
import 'package:flutter/material.dart';
import '../models/character.dart';

// Classe para gerenciar os dados de login
class UserAccount {
  final String email;
  final String password;
  UserAccount({required this.email, required this.password});
}

class RpgProvider extends ChangeNotifier {
  // --- LÓGICA DE AUTENTICAÇÃO E SESSÃO ---
  final List<UserAccount> _users = [
    UserAccount(email: 'admin@teste.com', password: '123'),
  ];

  UserAccount? _currentUser; // Guarda quem está logado no momento

  // Mapa que liga o e-mail do usuário à sua própria lista de personagens
  final Map<String, List<Character>> _charactersByUser = {
    'admin@teste.com': [
      Character(id: '1', name: 'Aragorn', charClass: 'Guerreiro', level: 5, hp: 45, maxHp: 45, mana: 0, maxMana: 0, inventory: ['Espada Longa', 'Tocha']),
      Character(id: '2', name: 'Gandalf', charClass: 'Mago', level: 20, hp: 25, maxHp: 25, mana: 100, maxMana: 100, inventory: ['Cajado Mágico', 'Poção de Mana']),
    ]
  };

  bool login(String email, String password) {
    try {
      // Verifica se o usuário existe
      _currentUser = _users.firstWhere((u) => u.email == email && u.password == password);

      // Se ele não tiver uma lista no mapa ainda, cria uma lista vazia
      if (!_charactersByUser.containsKey(email)) {
        _charactersByUser[email] = [];
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false; // Usuário não encontrado ou senha errada
    }
  }

  bool registerUser(String email, String password) {
    if (_users.any((u) => u.email == email)) {
      return false;
    }
    _users.add(UserAccount(email: email, password: password));
    _charactersByUser[email] = []; // Já cria a gaveta de personagens para o novo usuário
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null; // Limpa a sessão
    notifyListeners();
  }

  // --- LÓGICA DO TEMA (DARK MODE) ---
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // --- LÓGICA DOS PERSONAGENS (AGORA ISOLADA POR USUÁRIO) ---

  // O 'getter' agora não retorna mais a lista global, mas sim a lista do usuário logado
  List<Character> get characters {
    if (_currentUser == null) return [];
    return _charactersByUser[_currentUser!.email] ?? [];
  }

  void addCharacter(Character character) {
    if (_currentUser != null) {
      _charactersByUser[_currentUser!.email]!.add(character);
      notifyListeners();
    }
  }

  void removeCharacter(String id) {
    if (_currentUser != null) {
      _charactersByUser[_currentUser!.email]!.removeWhere((char) => char.id == id);
      notifyListeners();
    }
  }

  void updateCharacter(Character updatedChar) {
    if (_currentUser != null) {
      final userChars = _charactersByUser[_currentUser!.email]!;
      final index = userChars.indexWhere((c) => c.id == updatedChar.id);
      if (index != -1) {
        userChars[index] = updatedChar;
        notifyListeners();
      }
    }
  }
}