import 'package:expense_trcker/main.dart';
import 'package:expense_trcker/model/database_transction.dart';
import 'package:expense_trcker/model/transaction.dart' as tx;
import 'package:sqflite/sqflite.dart';

Future<void> insertTransaction(DatabaseTransaction transaction) async {
  final Database db = await database;
  await db.insert(
    'transactions',
    transaction.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<tx.Transaction>> getTransactions() async {
  // get a reference to the data base
  final Database db = await database;
  //query the database to get the data
  List<Map<String, dynamic>> maps = await db.query('transactions');
  // convert the list<Map<String,dynamic>> to a List<Task>
  List<tx.Transaction> transactions = List.generate(maps.length, (index) {
    return tx.Transaction(
        id: maps[index]['id'],
        title: maps[index]['title'],
        price: maps[index]['price'],
        time: DateTime.fromMillisecondsSinceEpoch(maps[index]['sqLiteTime']));
  });
  return transactions;
}

Future<void> deleteTransaction(int index) async {
  // get a reference to the data base
  final Database db = await database;
// delete the given Task.
  await db.delete(
    'transactions',
    // Ensure that the Dog has a matching id.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [index],
  );
}
