import 'package:flutter/material.dart';
import '../components/editor.dart';
import 'tela_inicial.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Ícone do App
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              
              // Título
              Text(
                'Controle de Gastos',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Faça login para continuar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 48),
              
              // Formulário de Login
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Campo Email
                      Editor(
                        controlador: _controladorEmail,
                        rotulo: 'Email',
                        dica: 'Digite seu email',
                        icone: Icons.email_outlined,
                        tipoTeclado: TextInputType.emailAddress,
                      ),
                      
                      // Campo Senha
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _controladorSenha,
                          obscureText: !_senhaVisivel,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Digite sua senha',
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _senhaVisivel
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _senhaVisivel = !_senhaVisivel;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Botão de Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _fazerLogin(context),
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Texto de demo
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, 
                             color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Dados para teste:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: usuario@teste.com\nSenha: 123456',
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fazerLogin(BuildContext context) {
    final String email = _controladorEmail.text.trim();
    final String senha = _controladorSenha.text.trim();

    // Validações
    if (email.isEmpty || senha.isEmpty) {
      _mostrarErro('Por favor, preencha todos os campos!');
      return;
    }

    if (!email.contains('@')) {
      _mostrarErro('Por favor, digite um email válido!');
      return;
    }

    if (senha.length < 6) {
      _mostrarErro('A senha deve ter pelo menos 6 caracteres!');
      return;
    }

    // Simulação de login (em um app real, aqui seria uma autenticação real)
    if (email == 'usuario@teste.com' && senha == '123456') {
      // Login bem-sucedido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TelaInicial(),
        ),
      );
    } else {
      _mostrarErro('Email ou senha incorretos!');
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }
}