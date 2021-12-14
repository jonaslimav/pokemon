import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../Servicos.dart';
import 'MostrarTodos.dart';
import 'model/Favorito.dart';

class Favoritos {
  static Favoritos _favoritos;
  static Database _databaseAnim;

  static final table = 'favoritos';
  static final columnId = 'id';
  static final columnIdp = 'idp';
  static final columnToken = 'token';

  Favoritos._createthis();

  factory Favoritos() {
    if (_favoritos == null) {
      // executado somente uma vez
      _favoritos = Favoritos._createthis();
    }
    return _favoritos;
  }

  Future<Database> get database async {
    if (_databaseAnim == null) {
      _databaseAnim = await initializeDatabase();
    }
    return _databaseAnim;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'pokemon.db';

    var pokemonDatabase =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return pokemonDatabase;
  }

  // Código SQL para criar o banco de dados e a tabela
  void _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER  PRIMARY KEY AUTOINCREMENT,
            $columnIdp INTEGER NOT NULL,
            $columnToken VARCHAR NOT NULL
          )
          ''');
  }

  Future<int> addfavorito(id) async {
    Database db = await this.database;
    Favorito favorito = new Favorito();
    favorito.idp = id;
    favorito.token = mostrarToken();
    var result = await db.query(table,
        where: '$columnIdp =? ', whereArgs: [id], limit: 1);
    print(result);
    if (result.isNotEmpty) {
      return await db.delete(table, where: '$columnIdp =?', whereArgs: [id]);
    }
    return await db.insert(table, favorito.toMap());
  }

  Future<int> excluirfavorito(int id) async {
    Database db = await this.database;

    return await db.delete(table, where: '$columnIdp =?', whereArgs: [id]);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<int>> listfavorito() async {
    List<int> lista = new List();
    Database db = await this.database;

    await db.query(table).then((value) => {
          for (Map<String, dynamic> map in value)
            {lista.add(Favorito.fromMap(map).idp)}
        });

    return lista;
  }

  Future<int> removeAll() async {
    Database db = await this.database;

    return await db.delete(table);
  }
}
