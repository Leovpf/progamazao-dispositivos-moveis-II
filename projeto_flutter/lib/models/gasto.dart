class Gasto {
  final int? id;
  final String descricao;
  final double valor;
  final String categoria;
  final DateTime data;

  Gasto(this.descricao, this.valor, this.categoria, this.data, {this.id});

  // Converter para Map (para salvar)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'data': data.millisecondsSinceEpoch,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Criar Gasto a partir de Map (para carregar)
  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      map['descricao'] ?? '',
      (map['valor'] is int) ? (map['valor'] as int).toDouble() : (map['valor']?.toDouble() ?? 0.0),
      map['categoria'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(map['data'] ?? 0),
      id: map['id'] as int?,
    );
  }

  @override
  String toString() {
    return 'Gasto{id: $id, descricao: $descricao, valor: $valor, categoria: $categoria, data: $data}';
  }
}