import 'dart:io';
import 'package:expense_trcker/model/transaction.dart';
import 'package:expense_trcker/services/transactions_provider.dart';
import 'package:expense_trcker/widgets/add_transaction_window.dart';
import 'package:expense_trcker/widgets/chart.dart';
import 'package:expense_trcker/widgets/custom_transaction_list.dart';
import 'package:expense_trcker/widgets/responsive_add-icon.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // a getter to dynamically return a list of all the
  // transaction that happened in the last 7 days.
  List<Transaction> get _recentTransaction {
    return Provider.of<TransactionsProvider>(context).transactions.where((tx) {
      return tx.time.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // getting a reference of the MediaQuery
    final mediaQuery = MediaQuery.of(context);
    // bool to track the orientation of the device
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    // a final to hold the appBar
    final appBar = AppBar(
      actions: [
        ResponsiveAddIcon(
          () => _launchAddWindow(context),
        ),
      ],
      elevation: 2.0,
      centerTitle: Platform.isIOS ? true : false,
      title: Text('Personal Expenses'),
    );
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS || _isLandscape
          ? Container()
          : FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              // launch the add transaction window
              onPressed: () => _launchAddWindow(context),
            ),
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isLandscape) ...[
            Flexible(
              child: Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.5,
                child: ExpensesChart(
                  _recentTransaction,
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.5,
                child: CustomTransactionList(),
              ),
            ),
          ] else if (!_isLandscape) ...[
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: ExpensesChart(
                _recentTransaction,
              ),
            ),
            Flexible(
              child: Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: CustomTransactionList(),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // a method to launch the add window
  void _launchAddWindow(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SingleChildScrollView(child: AddTransactionWindow());
        });
  }
}
