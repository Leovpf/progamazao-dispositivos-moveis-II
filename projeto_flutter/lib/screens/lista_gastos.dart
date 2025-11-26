import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gasto.dart';
import '../database/dao/gastos_dao.dart';
import 'formulario_gasto.dart';

class ListaGastos extends StatefulWidget {
  const ListaGastos({super.key});

  @override
  State<ListaGastos> createState() => _ListaGastosState();
}

class _ListaGastosState extends State<ListaGastos> {
  late Future<List<Gasto>> _futureGastos;

  @override
  void initState() {
    super.initState();
    _futureGastos = GastosDao.findAll();
  }

  // Recarregar lista
  void _recarregar() {
    setState(() {
      _futureGastos = GastosDao.findAll();
    });
  }

  // Mostrar dialog de confirmação para deletar um gasto
  void _confirmarRemocao(Gasto gasto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Gasto'),
        content: Text('Tem certeza que deseja remover "${gasto.descricao}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (gasto.id != null) {
                await GastosDao.delete(gasto.id!);
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gasto "${gasto.descricao}" removido!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                _recarregar();
              }
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  // Limpar todos os gastos
  Future<void> _limparTodosGastos() async {
    await GastosDao.deleteAll();
    _recarregar();
  }

  // Confirmar limpeza de todos os gastos
  void _confirmarLimparTodos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Todos os Gastos'),
        content: const Text(
          'Tem certeza que deseja remover TODOS os gastos?\n\n'
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _limparTodosGastos();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todos os gastos foram removidos!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Limpar Todos'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Gastos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'limpar_todos') {
                _confirmarLimparTodos();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'limpar_todos',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Limpar todos'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Gasto>>(
        future: _futureGastos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final gastos = snapshot.data ?? [];
          if (gastos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum gasto cadastrado',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toque no botão + para adicionar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Gasto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                          .format(_calcularTotal(gastos)),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: gastos.length,
                  itemBuilder: (context, index) {
                    final gasto = gastos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormularioGasto(gastoParaEditar: gasto),
                            ),
                          ).then((sucesso) {
                            if (sucesso == true) {
                              _recarregar();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Icon(
                            _getIconeCategoria(gasto.categoria),
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          gasto.descricao,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gasto.categoria),
                            Text(
                              DateFormat('dd/MM/yyyy').format(gasto.data),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              NumberFormat.currency(
                                      locale: 'pt_BR', symbol: 'R\$')
                                  .format(gasto.valor),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _confirmarRemocao(gasto),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              tooltip: 'Remover gasto',
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioGasto(),
            ),
          ).then((novoGasto) {
            if (novoGasto == true) {
              _recarregar();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  double _calcularTotal(List<Gasto> gastos) {
    return gastos.fold(0.0, (total, gasto) => total + gasto.valor);
  }

  IconData _getIconeCategoria(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'alimentação':
        return Icons.restaurant;
      case 'transporte':
        return Icons.directions_car;
      case 'lazer':
        return Icons.movie;
      case 'saúde':
        return Icons.local_hospital;
      case 'educação':
        return Icons.school;
      case 'casa':
        return Icons.home;
      default:
        return Icons.shopping_cart;
    }
  }
}