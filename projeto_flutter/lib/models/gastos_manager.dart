import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'gasto.dart';

class GastosManager {
  static const String _keyGastos = 'gastos';

  // Carregar gastos salvos
  static Future<List<Gasto>> carregarGastos() async {
    final prefs = await SharedPreferences.getInstance();
    final gastosJson = prefs.getStringList(_keyGastos) ?? [];
    
    List<Gasto> gastos = [];
    for (String gastoString in gastosJson) {
      final gastoMap = json.decode(gastoString);
      gastos.add(Gasto.fromMap(gastoMap));
    }
    
    // Se não há gastos salvos, adicionar exemplos para demonstração
    if (gastos.isEmpty) {
      gastos = _gastosExemplo();
      await salvarGastos(gastos);
    }
    
    return gastos;
  }

  // Gastos de exemplo para demonstração
  static List<Gasto> _gastosExemplo() {
    final agora = DateTime.now();
    return [
      Gasto('Almoço no restaurante', 25.50, 'Alimentação', agora.subtract(const Duration(days: 1))),
      Gasto('Uber para o trabalho', 12.00, 'Transporte', agora.subtract(const Duration(days: 2))),
      Gasto('Cinema com amigos', 30.00, 'Lazer', agora.subtract(const Duration(days: 3))),
      Gasto('Farmácia - remédios', 45.80, 'Saúde', agora.subtract(const Duration(days: 4))),
      Gasto('Supermercado', 85.60, 'Casa', agora.subtract(const Duration(days: 5))),
    ];
  }

  // Salvar gastos
  static Future<void> salvarGastos(List<Gasto> gastos) async {
    final prefs = await SharedPreferences.getInstance();
    final gastosJson = gastos.map((gasto) => json.encode(gasto.toMap())).toList();
    await prefs.setStringList(_keyGastos, gastosJson);
  }

  // Limpar todos os gastos (usado no logout)
  static Future<void> limparGastos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyGastos);
  }
}