import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class StatusDatabaseScreen extends StatefulWidget {
  const StatusDatabaseScreen({super.key});

  @override
  State<StatusDatabaseScreen> createState() => _StatusDatabaseScreenState();
}

class _StatusDatabaseScreenState extends State<StatusDatabaseScreen> {
  List<String> _tables = [];
  Map<String, int> _counts = {};
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkDatabase();
  }

  Future<void> _checkDatabase() async {
    try {
      final db = await AppDatabase.instance.database;
      final tablesRaw = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      final tables = tablesRaw.map((e) => e['name'] as String).where((n) => n != 'android_metadata' && n != 'sqlite_sequence').toList();
      final Map<String, int> counts = {};
      for (final t in tables) {
        final res = await db.rawQuery('SELECT COUNT(*) AS c FROM $t');
        final c = (res.first['c'] is int) ? res.first['c'] as int : int.tryParse('${res.first['c']}') ?? 0;
        counts[t] = c;
      }
      setState(() {
        _tables = tables;
        _counts = counts;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status do Banco'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Erro: $_error'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tabelas encontradas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      if (_tables.isEmpty) const Text('Nenhuma tabela encontrada'),
                      for (final t in _tables)
                        Card(
                          child: ListTile(
                            title: Text(t),
                            subtitle: Text('Registros: ${_counts[t] ?? 0}'),
                          ),
                        ),
                      const SizedBox(height: 16),
                      const Text('Exemplo DDL usado:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const SelectableText('''
CREATE TABLE gastos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  descricao TEXT NOT NULL,
  valor REAL NOT NULL,
  categoria TEXT NOT NULL,
  data INTEGER NOT NULL
)
'''),
                    ],
                  ),
                ),
    );
  }
}
