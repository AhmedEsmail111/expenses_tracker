import 'package:expense_trcker/widgets/transaction_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:expense_trcker/services/transactions_provider.dart';

class CustomTransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<TransactionsProvider>(context, listen: true)
            .getAllTransactions(),
        builder: (context, snapShot) {
          Widget returnedWidget;
          if (Provider.of<TransactionsProvider>(context).transactions.isEmpty) {
            returnedWidget = LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.15,
                    child: Text(
                      'No Transaction Yet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  // if (MediaQuery.of(context).orientation ==
                  //     Orientation.portrait)
                  Flexible(
                    child: Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              );
            });
            createElement();
          } else {
            returnedWidget = ListView.builder(
              itemCount:
                  Provider.of<TransactionsProvider>(context, listen: true)
                      .transactions
                      .length,
              itemBuilder: (context, index) {
                final tx =
                    Provider.of<TransactionsProvider>(context, listen: true)
                        .transactions[index];
                return TransactionItem(
                    tx: tx,
                    delete: () => Provider.of<TransactionsProvider>(context,
                            listen: false)
                        .delete(tx.id) as Function);
              },
            );
            createElement();
          }

          return returnedWidget;
        });
  }
}
