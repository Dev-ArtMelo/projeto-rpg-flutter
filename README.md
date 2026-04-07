# 🐉 Gerenciador de RPG

[cite_start]Aplicativo multiplataforma desenvolvido como **Projeto Prático** para a disciplina de **Mobile 2**. O objetivo do app é facilitar a vida de jogadores de RPG de mesa, permitindo a criação, edição e gerenciamento completo de fichas de personagens, além de contar com ferramentas essenciais como rolagem de dados virtuais.

---

## 👥 Equipe de Desenvolvimento

Este projeto foi desenvolvido em conjunto pelos alunos da graduação em Engenharia de Software:

* **Arthur Santos Melo** - RA: 831540
* **Gabriel Luís dos Santos Justino** - RA: 838858
* **Hugo Alves Barbosa de Freitas** - RA: 840239

---

## ⚙️ Funcionalidades

[cite_start]O aplicativo atende a todos os requisitos funcionais exigidos pela disciplina [cite: 10][cite_start], incluindo os sistemas de autenticação e as mecânicas específicas do tema[cite: 70, 75]:

**Autenticação e Sessão:**
* [cite_start]🔐 **Login de Usuário:** Sistema de acesso com validação de dados.
* [cite_start]📝 **Cadastro:** Criação de novas contas com validação de e-mail e senhas.
* [cite_start]🔑 **Recuperação de Senha:** Simulação de envio de instruções para contas cadastradas.
* 🚪 **Logout:** Encerramento seguro da sessão, com dados isolados por usuário.

**Mecânicas de RPG (Funcionalidades Específicas):**
1. [cite_start]**Listagem de Heróis:** Exibição dinâmica dos personagens cadastrados pelo usuário ativo.
2. **Criação de Personagem:** Formulário para adicionar novos heróis (Nome, Classe, Nível).
3. **Gerenciamento de Ficha:** Painel interativo para alterar Vida (HP) e Mana dinamicamente, além de um sistema completo de inventário para adicionar ou remover itens.
4. [cite_start]**Edição de Status:** Atualização das informações base do personagem.
5. **Taverna dos Dados:** Sistema de rolagem onde o jogador pode escolher o tipo do dado (D4 a D100) e a quantidade, gerando um cálculo automático do resultado.

**Extras (UI/UX):**
* 🌙 **Dark Mode:** Botão interativo para alternar o tema do aplicativo entre claro e escuro.
* [cite_start]ℹ️ **Tela Institucional (Sobre):** Informações detalhadas sobre a equipe e o objetivo da aplicação.

---

## 🛠️ Tecnologias Utilizadas

* [cite_start]**[Flutter SDK](https://flutter.dev/):** Framework para desenvolvimento da interface multiplataforma.
* [cite_start]**[Dart](https://dart.dev/):** Linguagem de programação base.
* [cite_start]**[Provider](https://pub.dev/packages/provider):** Gerenciamento de estado (ChangeNotifier) para manter os dados dos personagens atualizados em tempo real entre as telas.

---

## 🚀 Como executar o projeto

[cite_start]Certifique-se de ter o ambiente Flutter configurado em sua máquina.

1. Clone este repositório:
   ```bash
   git clone [https://github.com/SeuUsuario/projeto-rpg-flutter.git](https://github.com/SeuUsuario/projeto-rpg-flutter.git)
