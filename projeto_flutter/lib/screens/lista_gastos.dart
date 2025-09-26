import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gasto.dart';
import '../models/gastos_manager.dart';
import 'formulario_gasto.dart';

class ListaGastos extends StatefulWidget {
  const ListaGastos({super.key});

  @override
  State<ListaGastos> createState() => _ListaGastosState();
}

class _ListaGastosState extends State<ListaGastos> {
  final List<Gasto> _gastos = [];

  @override
  void initState() {
    super.initState();
    _carregarGastos();
  }

  // Carregar gastos salvos
  Future<void> _carregarGastos() async {
    final gastos = await GastosManager.carregarGastos();
    setState(() {
      _gastos.clear();
      _gastos.addAll(gastos);
    });
  }

  // Adicionar novo gasto
  void _adicionarGasto(Gasto novoGasto) {
    setState(() {
      _gastos.add(novoGasto);
    });
    GastosManager.salvarGastos(_gastos);
  }

  // Remover gasto
  void _removerGasto(int index) {
    setState(() {
      _gastos.removeAt(index);
    });
    GastosManager.salvarGastos(_gastos);
  }

  // Mostrar dialog de confirmação para deletar
  void _confirmarRemocao(int index, String descricao) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Gasto'),
        content: Text('Tem certeza que deseja remover "$descricao"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removerGasto(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gasto "$descricao" removido!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }

  // Limpar todos os gastos
  void _limparTodosGastos() {
    setState(() {
      _gastos.clear();
    });
    GastosManager.salvarGastos(_gastos);
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
          if (_gastos.isNotEmpty)
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
      body: _gastos.isEmpty
          ? const Center(
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
            )
          : Column(
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
                            .format(_calcularTotal()),
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
                    itemCount: _gastos.length,
                    itemBuilder: (context, index) {
                      final gasto = _gastos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
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
                                onPressed: () =>
                                    _confirmarRemocao(index, gasto.descricao),
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioGasto(),
            ),
          ).then((novoGasto) {
            if (novoGasto != null) {
              _adicionarGasto(novoGasto);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  double _calcularTotal() {
    return _gastos.fold(0.0, (total, gasto) => total + gasto.valor);
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