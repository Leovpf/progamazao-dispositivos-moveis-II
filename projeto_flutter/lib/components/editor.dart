import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  final TextInputType? tipoTeclado;

  const Editor({
    super.key,
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
    this.tipoTeclado,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
          prefixIcon: icone != null ? Icon(icone) : null,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}