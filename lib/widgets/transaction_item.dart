import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_trcker/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final Function delete;
  TransactionItem({@required this.tx, @required this.delete});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: ListTile(
          leading: CircleAvatar(
            radius: 40.0,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FittedBox(
                child: Text(
                  '\$${tx.price.toStringAsFixed(1)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            tx.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(tx.time),
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 13.0,
              color: Colors.grey,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  onPressed: () => delete,
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).errorColor,
                  ),
                  icon: Icon(
                    Icons.delete,
                  ),
                  label: Text(
                    'Delete',
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: delete,
                )),
    );
  }
}
