import 'package:expense_trcker/screens/home_page_screen.dart';
import 'package:expense_trcker/services/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    join(await getDatabasesPath(), 'transaction_database.db'),
    onCreate: (db, version) {
      db.execute(
        "CREATE TABLE transactions(id INTEGER PRIMARY KEY, title TEXT, price REAL, sqLiteTime INTEGER,time NULL)",
      );
    },
    version: 1,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TransactionsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
          ),
        ),
        title: 'Personal Expenses',
        home: MyHomePage(),
      ),
    );
  }
}
