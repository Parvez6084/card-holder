import 'package:card_holder/models/contract_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBSQLite {
  static final String _createTableContact = '''create table $tableContact(
  $colID integer primary key,
  $colName text not null,
  $colDesignation text not null,
  $colPhone text not null,
  $colEmail text not null,
  $colCompanyName text not null,
  $colAddress text not null,
  $colImage text not null,
  $colFavorite integer not null default 0,
  $colWebSite text not null)''';

  static Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contract.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(_createTableContact);
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (newVersion == 2) {
        await db.execute('alter table $tableContact add column $colImage text');
        await db.execute('alter table $tableContact add column $colFavorite integer not null default 0');
      }
    });
  }

  static Future<int> insertNewContact(ContractModel contractModel) async {
    final db = await _open();
    return db.insert(tableContact, contractModel.toMap());
  }

  static Future<List<ContractModel>> getAllContract() async {
    final db = await _open();
    final /*List<Map<String, dynamic>>*/ mapList = await db.query(tableContact);
    return List.generate(
        mapList.length, (index) => ContractModel.fromMap(mapList[index]));
  }

  static Future<ContractModel> getContractByID(int id) async {
    final db = await _open();
    final mapList =
        await db.query(tableContact, where: '$colID = ?', whereArgs: [id]);
    return ContractModel.fromMap(mapList.first);
  }
  static Future<List<ContractModel>> getFavoriteContractByID(int id) async {
    final db = await _open();
    final mapList =
        await db.query(tableContact, where: '$colFavorite = ?', whereArgs: [1]);
    return List.generate(
        mapList.length, (index) => ContractModel.fromMap(mapList[index]));
  }

  static Future<int> deleteContractByID(int id) async {
    final db = await _open();
    return db.delete(tableContact, where: '$colID = ?', whereArgs: [id]);
  }

  static Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return db.update(tableContact, {colFavorite: value},
        where: '$colID = ?', whereArgs: [id]);
  }



}
