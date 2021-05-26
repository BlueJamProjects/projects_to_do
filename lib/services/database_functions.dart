import 'database_helper.dart';



void databaseInsert({required String text, var dbHelper, required  String complete}) async {
  // row to insert
  Map<String, dynamic> row = {
    DatabaseHelper.columnText : text,
    DatabaseHelper.columnComplete  : complete,
  };
  final id = await dbHelper.insert(row);
  print('inserted row id: $id');
}


void databaseUpdate({required int id, required String text,required var dbHelper,required String complete}) async {
  // row to update
  Map<String, dynamic> row = {
    DatabaseHelper.columnId   : id,
    DatabaseHelper.columnText : text,
    DatabaseHelper.columnComplete  : complete,
  };
  print("id : $id , text : $text, complete : $complete");
  final rowsAffected = await dbHelper.update(row);
  print('updated $rowsAffected row(s)');
}

void databaseDelete({required int id, var dbHelper}) async {
  // Assuming that the number of rows is the id for the last row.
  //await dbHelper.queryRowCount();
  final rowsDeleted = await dbHelper.delete(id);
  print('deleted $rowsDeleted row(s): row $id');
}

