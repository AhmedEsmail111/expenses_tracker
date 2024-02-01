import 'package:expenses/widgets/chart/chart.dart';
import 'package:expenses/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // a list of the registered expenses
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'cinema',
      amount: 11.9,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  // a method to pass to the NewExpense  screen to add a new expense to the list when the user press save changes
  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // a method to pass to the expenses list to remove an expense when the user does so
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // clear any snackBars first before showing one that an expense has been deleted
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted!'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  // a method to open the form for adding a new expense when the user hit the add button on the appBar
  void _onOpenNewExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(_addNewExpense));
  }

  @override
  Widget build(BuildContext context) {
    // a var to control what we show on the screen based on whether the list of expenses is empty or not
    Widget mainWidget = const Center(
      child: Text('NO Expenses added. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainWidget = ExpensesList(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your EXpenses '),
        actions: [
          IconButton(
            onPressed: _onOpenNewExpense,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainWidget,
          ),
        ],
      ),
    );
  }
}
