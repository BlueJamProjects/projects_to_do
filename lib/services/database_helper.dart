import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //sets this class up as a singleton

  static final DatabaseHelper _instance = new DatabaseHelper._internal();

  DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;


  //the variables that will be used to determine the attributes of the database

  //name of the Database
  static final _databaseName = "projects_to_do.db";

  //version of the database
  static final _databaseVersion = 1;

  //name of the table
  static final table = 'projects';

  //name of the Id column
  //this column contains the unique int id of a row
  static final columnId = 'id';

  //name of the Text column
  //this column contains the String text of a given row
  static final columnText = 'text';

  //name of the Complete column
  //this column contains a String with the value 'True' of 'False' that will be converted into a boolean when accessed elsewhere
  static final columnComplete = 'complete';


  // gets the database using the _initDatabase function
  Future<Database> get database async {
    Database _database = await _initDatabase();
    return _database;
  }

  // opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // the function called when the database is first created
  // creates a table with the previously defined variables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnText TEXT NOT NULL,
            $columnComplete TEXT NOT NULL
          )
          ''');
  }

  //*** Methods ***
  // the methods called elsewhere in the app

  // inserts a row in the database
  // takes the parameter text and complete as Strings and will add them to a new row with a unique id

  Future<void> insert({required String text, required bool? complete}) async {

    String stringComplete = complete == true? "true": "false";
    Map<String, dynamic> row = {
      DatabaseHelper.columnText : text,
      DatabaseHelper.columnComplete  : stringComplete,
    };
    Database db = await _instance.database;
    await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  // returns all rows in the table as a list of Maps
  // the each map is a row where the keys and values of the map correspond to the rows columns and their values
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await _instance.database;
    return await db.query(table);
  }


  // updates a row in the database based on a specific id
  // it takes 3 arguments for for the row: id, text and complete (complete is a bool? here)

  Future<void> update({required int id, required String text,required bool? complete}) async {
    String completeText = complete == true? "true": "false";
    Database db = await _instance.database;
    await db.rawQuery('UPDATE $table SET $columnText = "$text",  $columnComplete = "$completeText" WHERE $columnId = $id');

    }

  // deletes a row
  // takes an id as an argument and deletes the row with that id
  Future<void> delete(int id) async {
    Database db = await _instance.database;
    await db.rawQuery('DELETE FROM $table WHERE $columnId = ${id.toString()}');
  }

}


