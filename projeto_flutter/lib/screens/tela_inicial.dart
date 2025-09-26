import 'package:flutter/material.dart';
import 'lista_gastos.dart';
import 'tela_login.dart';
import '../models/gastos_manager.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Gastos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sair'),
                  content: const Text('Tem certeza que deseja sair?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context); // Fecha o dialog
                        // Limpar gastos salvos no logout
                        await GastosManager.limparGastos();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaLogin(),
                          ),
                        );
                      },
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
    );
  }
}