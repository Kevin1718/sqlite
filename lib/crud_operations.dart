import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'student.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database _db;
  static const String Id = 'controlum';
  static const String NAME = 'name';
  static const String LASTNAME = 'lastname';
  static const String SURNAME = 'surname';
  static const String MATRI = 'matri';
  static const String MAIL = 'mail';
  static const String TEL = 'tel';
  static const String TABLE = 'Students';
  static const String DB_NAME = 'students4.db';

//creacion de la base de datos

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    print(appDirectory);
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($Id INTEGER PRIMARY KEY, $NAME TEXT, $LASTNAME TEXT, $SURNAME TEXT, $MATRI TEXT, $MAIL TEXT, $TEL TEXT)");
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, LASTNAME, SURNAME,MATRI, MAIL, TEL]);
    List<Student> studentss = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }
  Future<bool> validateInsert(Student student) async {
    var dbClient = await db;
    var co = student.matri;
    List<Map> maps = await dbClient
    //CONSULTA SI LA MATRICULA SE ENCUENTRA EN LA BASE
        .rawQuery("select $Id from $TABLE where $MATRI = $co");
    if (maps.length == 0) {
      return true;
    }else{
      return false;
    }
  }


//SELECT LIKE
  Future<List<Student>>busqueda(String inicio) async{
    final bd = await db;
    //CONSULTA
    List<Map> maps = await bd.rawQuery("SELECT * FROM $TABLE WHERE $MATRI LIKE '$inicio%'");
    List<Student> studentss =[];
    print(maps);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++){
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

//Save or insert
  Future<Student> insert(Student student) async {
    var dbClient = await db;
    student.controlum = await dbClient.insert(TABLE, student.toMap());
    return student;
  }

//Delete
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$Id = ?', whereArgs: [id]);
  }

//Update
  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, student.toMap(),
        where: '$Id = ?', whereArgs: [student.controlum]);
  }

//Close Database
  Future closedb() async {
    var dbClient = await db;
    dbClient.close();
  }
}