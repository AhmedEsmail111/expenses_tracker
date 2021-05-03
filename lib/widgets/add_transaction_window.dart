import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expense_trcker/services/transactions_provider.dart';

import 'package:expense_trcker/widgets/adaptive_text_button.dart';
import 'package:expense_trcker/model/database_transction.dart';
import '../constants.dart';

class AddTransactionWindow extends StatefulWidget {
  @override
  _AddTransactionWindowState createState() => _AddTransactionWindowState();
}

class _AddTransactionWindowState extends State<AddTransactionWindow> {
  // tow variables to control the textFields input values
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  // a variable to store the date picked by user
  DateTime _pickedDate;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) {
                _addTransaction();
              },
              controller: _titleEditingController,
              decoration: kAddTextFieldInputDecoration.copyWith(
                hintText: 'The title',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onSubmitted: (_) {
                _addTransaction();
              },
              keyboardType: TextInputType.number,
              controller: _priceEditingController,
              decoration: kAddTextFieldInputDecoration,
            ),
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? 'No Date Chosen!'
                          : 'picked date: ${DateFormat.yMMMd().format(_pickedDate)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  AdaptiveTextButton('Choose a Date', _showDatePicker),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    _addTransaction();
                  },
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontSize: 20.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // a method to show the date picker to the user to choose a date from
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  // a method to control adding a new transaction
  void _addTransaction() {
    if (_priceEditingController.text.isEmpty) {
      return;
    }
    final price = double.parse(_priceEditingController.text);
    if (_titleEditingController.text.isNotEmpty &&
        _priceEditingController.text.isNotEmpty &&
        price > 0 &&
        _pickedDate != null) {
      final transaction = DatabaseTransaction(
          title: _titleEditingController.text,
          price: price,
          sqLiteTime: _pickedDate.millisecondsSinceEpoch);
      Provider.of<TransactionsProvider>(context, listen: false)
          .add(transaction: transaction);
      Navigator.pop(context);
    }
  }
}
