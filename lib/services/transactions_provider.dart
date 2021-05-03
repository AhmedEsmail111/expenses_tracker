import 'dart:collection';
import 'package:expense_trcker/model/database_transction.dart';
import 'package:expense_trcker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_trcker/database/database_methods.dart';

class TransactionsProvider extends ChangeNotifier {
  // TransactionsProvider() {
  //   getAllTransactions();
  // }

  // our list of transactions
  List<Transaction> _transactions = [];
// unModifiable copy of our list to be exposed to other classes
  List<Transaction> get transactions {
    return UnmodifiableListView(_transactions);
  }

// a method to control adding a new transaction
  void add({DatabaseTransaction transaction}) {
    insertTransaction(transaction);
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    _transactions = await getTransactions();
    notifyListeners();
  }

  // a method to delete a transaction
  void delete(int index) {
    deleteTransaction(index);
    notifyListeners();
  }
}
