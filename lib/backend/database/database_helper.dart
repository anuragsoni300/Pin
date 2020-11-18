import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  
  static final _dbname = 'PIN.db';
  static final _dbversion = 1;
  static final _tablename = 'favorites';
  static final primeid = '_id';
  static final id = 'id';
  static final likes = 'likes';
  static final urls = 'urls';
  static final blurhash = 'blurhash';
  static final height = 'height';
  static final width = 'width';
  static final description = 'description';
  static final links = 'links';
  static final portfolioimage = 'portfolioimage';

  DatabaseHelper._privatecontructor();
  static final DatabaseHelper instance = DatabaseHelper._privatecontructor();

  static Database _database;
  Future<Database> get database async{

    if(_database!=null)
      return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory);
    String path = join(directory.path,_dbname);
    return await openDatabase(path,version: _dbversion,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version){
    db.execute(
      '''
      CREATE TABLE $_tablename(
       $primeid  INTEGER PRIMARY KEY AUTOINCREMENT,
       $id TEXT,
       $likes INT,
       $urls TEXT,
       $blurhash TEXT,
       $height INT,
       $width INT,
       $description TEXT,
       $links TEXT,
       $portfolioimage TEXT
      )
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async{

  Database db = await instance.database;
  return await db.insert(_tablename, row);

}

  Future<List<Map<String,dynamic>>> queryAll() async {

    Database db = await instance.database;
    return await db.query(_tablename);
  

  }

  Future delete(String pid) async {

    Database db = await instance.database;
    return await db.delete(_tablename,where: 'id = ?',whereArgs: [pid]);

  }

}
