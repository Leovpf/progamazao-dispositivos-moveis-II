import 'package:flutter/material.dart';
import '../components/editor.dart';
import '../models/gasto.dart';
import '../database/dao/gastos_dao.dart';

class FormularioGasto extends StatefulWidget {
  const FormularioGasto({super.key});

  @override
  State<FormularioGasto> createState() => _FormularioGastoState();
}

class _FormularioGastoState extends State<FormularioGasto> {
  final TextEditingController _controladorDescricao = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();
  String _categoriaSelecionada = 'Alimentação';

  final List<String> _categorias = [
    'Alimentação',
    'Transporte',
    'Lazer',
    'Saúde',
    'Educação',
    'Casa',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Gasto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorDescricao,
              rotulo: 'Descrição',
              dica: 'Ex: Almoço no restaurante',
              icone: Icons.description,
            ),
            Editor(
              controlador: _controladorValor,
              rotulo: 'Valor',
              dica: 'Ex: 25.50',
              icone: Icons.attach_money,
              tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                value: _categoriaSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                items: _categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (novaCategoria) {
                  setState(() {
                    _categoriaSelecionada = novaCategoria!;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _criarGasto(context),
                  child: const Text('Adicionar Gasto'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _criarGasto(BuildContext context) async {
    final String descricao = _controladorDescricao.text;
    final String valorTexto = _controladorValor.text;

    if (descricao.isEmpty || valorTexto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final double? valor = double.tryParse(valorTexto.replaceAll(',', '.'));
    if (valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira um valor válido!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final Gasto novoGasto = Gasto(
      descricao,
      valor,
      _categoriaSelecionada,
      DateTime.now(),
    );

    try {
      await GastosDao.inserir(novoGasto);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gasto adicionado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      // Retornar sinal de sucesso para a lista (para recarregar)
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controladorDescricao.dispose();
    _controladorValor.dispose();
    super.dispose();
  }
}