import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// initiating a uuid  object
const uuid = Uuid();
// initiating a an INTL Format Date Object
final formatter = DateFormat.yMd();

// create an enum to hold the the differnt categories of the expense
enum Category { food, leisure, travel, work }

// a map for storing different icons based on the different categories
const iconCategories = {
  Category.food: Icons.food_bank,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // a getter to help us get a formatted version of the date
  String get formattedDate {
    return formatter.format(date);
  }
}

// a class for managing the chart as buckets that each one contain only one category of expenses
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  // a utility constructor to filter the expenses and only assign the expenses that belongs to that bucket to it
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();

  //  a getter to obtain the total sum of expenses that belong to this bucket
  double get totalExpensesAmount {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
