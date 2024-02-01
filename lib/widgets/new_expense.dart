import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this._onSavechanges, {super.key});

  // a list to pass the Expenses list to so we can add any new expenses when the user submits them
  final void Function(Expense expense) _onSavechanges;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // initiate a textEditingController to handle the user input for the title
  final _titleController = TextEditingController();
  // initiate a textEditingController to handle the user input for the title
  final _amountController = TextEditingController();
  // a var to hold the date the user will chose
  DateTime? _selectedDate;
  // an object of the Intl package
  final _formatter = DateFormat.yMd();
  // a var to store the selected category from the DropDownMenu
  Category _selectedCategory = Category.leisure;

  // a method to show the Date Picker for the user and then store that selected date in a variable
  void _onChooseDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // a method to validate the inputs of the user before creating a new expense with these inputs
  void _onSubmitExpenseDate() {
    final inputtedAmount = double.tryParse(_amountController.text);
    final isAmountvalid = inputtedAmount == null || inputtedAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Title ,Amount, or Date in invalid , please try again!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          });
      return;
    }
    // if no errors we will add the data to the expenses list and refresh the UI
    widget._onSavechanges(Expense(
      title: _titleController.text,
      amount: inputtedAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  // use the dispose method to remove controller
  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('amount'),
                    prefix: Text('\$ '),
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected!'
                        : _formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _onChooseDate,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _onSubmitExpenseDate,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
