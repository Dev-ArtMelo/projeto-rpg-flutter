// lib/models/character.dart

class Character {
  String id;
  String name;
  String charClass;
  int level;
  int hp;
  int maxHp;
  int mana;
  int maxMana;
  List<String> inventory;

  Character({
    required this.id,
    required this.name,
    required this.charClass,
    this.level = 1,
    this.hp = 20,
    this.maxHp = 20,
    this.mana = 10,
    this.maxMana = 10,
    List<String>? inventory, // Recebe como opcional
  }) : inventory = inventory ?? []; // Se for nulo, cria uma lista mutável vazia []
}