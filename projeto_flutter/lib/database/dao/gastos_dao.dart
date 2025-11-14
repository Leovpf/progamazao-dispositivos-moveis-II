import 'package:sqflite/sqflite.dart';
import '../../models/gasto.dart';
import '../app_database.dart';

class GastosDao {
  static const String table = 'gastos';

  // Inserir gasto e retornar id gerado
  static Future<int> inserir(Gasto gasto) async {
    final db = await AppDatabase.instance.database;
    return await db.insert(table, gasto.toMap());
  }

  // Buscar todos os gastos ordenados por data desc
  static Future<List<Gasto>> findAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(table, orderBy: 'data DESC');
    return result.map((m) => Gasto.fromMap(m)).toList();
  }

  static Future<int> update(Gasto gasto) async {
    final db = await AppDatabase.instance.database;
    return await db.update(table, gasto.toMap(), where: 'id = ?', whereArgs: [gasto.id]);
  }

  static Future<int> delete(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteAll() async {
    final db = await AppDatabase.instance.database;
    return await db.delete(table);
  }

  static Future<int> count() async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
