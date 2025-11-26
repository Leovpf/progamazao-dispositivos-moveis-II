import 'package:flutter/material.dart';
import '../components/editor.dart';
import '../models/gasto.dart';
import '../database/dao/gastos_dao.dart';

class FormularioGasto extends StatefulWidget {
  // Alteração: Recebe o gasto opcional para edição
  final Gasto? gastoParaEditar;

  const FormularioGasto({super.key, this.gastoParaEditar});

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
  void initState() {
    super.initState();
    // Alteração: Se houver um gasto para editar, preenche os campos
    if (widget.gastoParaEditar != null) {
      _controladorDescricao.text = widget.gastoParaEditar!.descricao;
      _controladorValor.text = widget.gastoParaEditar!.valor.toString();
      _categoriaSelecionada = widget.gastoParaEditar!.categoria;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Alteração: Título dinâmico
        title: Text(widget.gastoParaEditar == null ? 'Novo Gasto' : 'Editar Gasto'),
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
                  child: Text(widget.gastoParaEditar == null ? 'Adicionar Gasto' : 'Salvar Alterações'),
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

    // Alteração: Mantém o ID e a Data original se for edição
    final Gasto novoGasto = Gasto(
      descricao,
      valor,
      _categoriaSelecionada,
      widget.gastoParaEditar?.data ?? DateTime.now(), // Se editar, mantém a data original
      id: widget.gastoParaEditar?.id, // Se editar, passa o ID existente
    );

    try {
      // Alteração: Decide se é INSERT ou UPDATE
      if (widget.gastoParaEditar != null) {
        await GastosDao.update(novoGasto);
      } else {
        await GastosDao.inserir(novoGasto);
      }
      
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.gastoParaEditar == null 
              ? 'Gasto adicionado com sucesso!' 
              : 'Gasto atualizado com sucesso!'),
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