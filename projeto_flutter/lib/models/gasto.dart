class Gasto {
  final String descricao;
  final double valor;
  final String categoria;
  final DateTime data;

  Gasto(this.descricao, this.valor, this.categoria, this.data);

  // Converter para Map (para salvar)
  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'data': data.millisecondsSinceEpoch,
    };
  }

  // Criar Gasto a partir de Map (para carregar)
  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      map['descricao'] ?? '',
      map['valor']?.toDouble() ?? 0.0,
      map['categoria'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(map['data'] ?? 0),
    );
  }

  @override
  String toString() {
    return 'Gasto{descricao: $descricao, valor: $valor, categoria: $categoria, data: $data}';
  }
}