import 'package:flutter/cupertino.dart';

class Transaction {
  final int id;
  final String title;
  final double price;
  final DateTime time;
  final int sqLiteTime;
  Transaction({
    this.id,
    this.sqLiteTime,
    @required this.title,
    this.time,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'time': this.time,
    };
  }
}
