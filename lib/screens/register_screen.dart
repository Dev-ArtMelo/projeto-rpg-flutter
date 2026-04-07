import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importação do Provider adicionada
import '../providers/rpg_provider.dart'; // Importação do RpgProvider adicionada

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register() {
    String name = _nameController.text;
    String email = _emailController.text.trim();
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError('Todos os campos são obrigatórios.');
      return;
    }
    if (!email.contains('@')) {
      _showError('E-mail inválido.');
      return;
    }
    if (password != confirmPassword) {
      _showError('As senhas não coincidem.');
      return;
    }

    // Tenta salvar o usuário usando a função do Provider
    bool success = Provider.of<RpgProvider>(context, listen: false).registerUser(email, password);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Volta para a tela de login
    } else {
      _showError('Este e-mail já está cadastrado!');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail')),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Telefone')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
            TextField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: 'Confirmação de senha'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}